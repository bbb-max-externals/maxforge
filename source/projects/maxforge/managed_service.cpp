#include "managed_service.hpp"

#include <sstream>
#include <cstdint>
#include <stdexcept>
#include <vector>
#ifdef _WIN32
#define NOMINMAX
#include <windows.h>
#else
#include <cerrno>
#include <csignal>
#include <cstring>
#include <dlfcn.h>
#include <mach-o/dyld.h>
#include <fcntl.h>
#include <spawn.h>
#include <sys/wait.h>
#include <unistd.h>
extern char **environ;
#endif

namespace maxforge {
namespace {
void module_anchor() {}

#ifdef _WIN32
auto module_directory() -> std::wstring {
	HMODULE module{};
	if(!GetModuleHandleExW(GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS |
		GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT,
		reinterpret_cast<LPCWSTR>(&module_anchor), &module)) {
		throw std::runtime_error("Cannot locate maxforge module");
	}
	std::vector<wchar_t> path(32768);
	const auto count = GetModuleFileNameW(module, path.data(), (DWORD)path.size());
	if(count == 0 || path.size() <= count) throw std::runtime_error("Invalid module path");
	const std::wstring value{path.data(), count};
	return value.substr(0, value.find_last_of(L"\\/"));
}
auto max_node_executable() -> std::wstring {
	std::vector<wchar_t> path(32768);
	const auto count = GetModuleFileNameW(nullptr, path.data(), (DWORD)path.size());
	if(count == 0 || path.size() <= count) throw std::runtime_error("Cannot locate running Max application");
	const std::wstring executable{path.data(), count};
	const auto directory = executable.substr(0, executable.find_last_of(L"\\/"));
	// Node for Max source/lib/constants.js: PLATFORM_STRING=pc_x64, NODE_CMD_PATH=bin/<platform>/node/node.exe.
	const auto candidate = directory + L"\\resources\\C74\\packages\\Node for Max\\source\\bin\\pc_x64\\node\\node.exe";
	const auto attributes = GetFileAttributesW(candidate.c_str());
	if(attributes != INVALID_FILE_ATTRIBUTES && !(attributes & FILE_ATTRIBUTE_DIRECTORY)) return candidate;
	throw std::runtime_error("Max's bundled Node runtime was not found; repair/update Max");
}
auto wide(const std::string &value) -> std::wstring {
	if(value.empty()) return {};
	const auto count = MultiByteToWideChar(CP_UTF8, MB_ERR_INVALID_CHARS, value.data(), (int)value.size(), nullptr, 0);
	if(count == 0) throw std::runtime_error("Invalid UTF-8 service argument");
	std::wstring result(count, L'\0');
	MultiByteToWideChar(CP_UTF8, MB_ERR_INVALID_CHARS, value.data(), (int)value.size(), result.data(), count);
	return result;
}
auto quote(const std::wstring &value) -> std::wstring {
	std::wstring result{L"\""};
	std::size_t slashes{};
	for(auto character : value) {
		if(character == L'\\') { ++slashes; continue; }
		result.append(character == L'"' ? slashes * 2 + 1 : slashes, L'\\');
		result += character;
		slashes = 0;
	}
	result.append(slashes * 2, L'\\');
	return result + L'"';
}
#else
auto module_directory() -> std::string {
	Dl_info information{};
	if(!dladdr(reinterpret_cast<void*>(&module_anchor), &information) || !information.dli_fname) {
		throw std::runtime_error("Cannot locate maxforge module");
	}
	const std::string path{information.dli_fname};
	return path.substr(0, path.find_last_of('/')) + "/../Resources/service";
}
auto max_node_executable() -> std::string {
	std::uint32_t size{};
	_NSGetExecutablePath(nullptr, &size);
	std::vector<char> path(size);
	if(_NSGetExecutablePath(path.data(), &size) != 0) throw std::runtime_error("Cannot locate running Max application");
	const std::string executable{path.data()};
	const auto node = executable.substr(0, executable.find_last_of('/')) +
		"/../Resources/C74/packages/Node for Max/source/bin/osx/node/node";
	if(access(node.c_str(), X_OK) != 0) throw std::runtime_error("Max's bundled Node runtime was not found; repair/update Max");
	return node;
}
#endif
}

auto managed_service::instance() -> managed_service& {
	static managed_service service;
	return service;
}
managed_service::~managed_service() { close(); }

void managed_service::close() {
#ifdef _WIN32
	if(input_) { CloseHandle(input_); input_ = nullptr; }
	if(output_handle_) { CloseHandle(output_handle_); output_handle_ = nullptr; }
	if(process_) { CloseHandle(process_); process_ = nullptr; }
#else
	if(0 <= input_) { ::close(input_); input_ = -1; }
	if(0 <= output_handle_) { ::close(output_handle_); output_handle_ = -1; }
	if(0 < process_) { waitpid(process_, nullptr, WNOHANG); }
#endif
}

auto managed_service::ready(const std::string &configuration) -> bool {
	if(!error_.empty()) throw std::runtime_error(error_);
	if(started_ && !configuration.empty() && configuration != configuration_) {
		throw std::runtime_error("All maxforge objects in one Max process must share the first object's @config");
	}
	try {
		if(!started_) start(configuration);
		read_output();
		if(0 < websocket_port_) return true;
		if(std::chrono::seconds(15) < std::chrono::steady_clock::now() - started_at_) {
			throw std::runtime_error("Bundled service startup timed out; restart Max after repairing the package");
		}
		return false;
	} catch(const std::exception &exception) {
		error_ = exception.what();
		close();
		throw;
	}
}

void managed_service::start(const std::string &configuration) {
	configuration_ = configuration;
	started_at_ = std::chrono::steady_clock::now();
#ifdef _WIN32
	const auto directory = module_directory() + L"\\maxforge-service";
	const auto executable = max_node_executable();
	const auto script = directory + L"\\dist\\live\\bin.js";
	SECURITY_ATTRIBUTES security{sizeof(SECURITY_ATTRIBUTES), nullptr, TRUE};
	HANDLE child_input{}, child_output{};
	if(!CreatePipe(&child_input, &input_, &security, 0)) throw std::runtime_error("Cannot create service input pipe");
	SetHandleInformation(input_, HANDLE_FLAG_INHERIT, 0);
	if(!CreatePipe(&output_handle_, &child_output, &security, 0)) {
		CloseHandle(child_input);
		throw std::runtime_error("Cannot create service output pipe");
	}
	SetHandleInformation(output_handle_, HANDLE_FLAG_INHERIT, 0);
	STARTUPINFOEXW startup{};
	startup.StartupInfo.cb = sizeof(startup);
	startup.StartupInfo.dwFlags = STARTF_USESTDHANDLES;
	startup.StartupInfo.hStdInput = child_input;
	startup.StartupInfo.hStdOutput = child_output;
	startup.StartupInfo.hStdError = child_output;
	SIZE_T size{};
	InitializeProcThreadAttributeList(nullptr, 1, 0, &size);
	std::vector<unsigned char> storage(size);
	startup.lpAttributeList = reinterpret_cast<LPPROC_THREAD_ATTRIBUTE_LIST>(storage.data());
	const HANDLE handles[]{child_input, child_output};
	const bool initialized = InitializeProcThreadAttributeList(startup.lpAttributeList, 1, 0, &size);
	const bool configured = initialized && UpdateProcThreadAttribute(startup.lpAttributeList, 0,
		PROC_THREAD_ATTRIBUTE_HANDLE_LIST, (void*)handles, sizeof(handles), nullptr, nullptr);
	std::wstring command = quote(executable) + L" " + quote(script) + L" " +
		std::to_wstring(GetCurrentProcessId()) + L" " + quote(wide(MAXFORGE_PACKAGE_VERSION)) + L" " + quote(wide(configuration));
	PROCESS_INFORMATION child{};
	const bool launched = configured && CreateProcessW(executable.c_str(), command.data(), nullptr, nullptr,
		TRUE, CREATE_NO_WINDOW | EXTENDED_STARTUPINFO_PRESENT, nullptr, directory.c_str(), &startup.StartupInfo, &child);
	if(initialized) DeleteProcThreadAttributeList(startup.lpAttributeList);
	CloseHandle(child_input);
	CloseHandle(child_output);
	if(!launched) throw std::runtime_error("Cannot launch Max's Node runtime; repair/update Max");
	process_ = child.hProcess;
	CloseHandle(child.hThread);
#else
	const auto directory = module_directory();
	const auto executable = max_node_executable();
	const auto script = directory + "/dist/live/bin.js";
	int input_pipe[2], output_pipe[2];
	if(pipe(input_pipe) != 0) throw std::runtime_error("Cannot create service input pipe");
	if(pipe(output_pipe) != 0) {
		::close(input_pipe[0]); ::close(input_pipe[1]);
		throw std::runtime_error("Cannot create service output pipe");
	}
	input_ = input_pipe[1];
	output_handle_ = output_pipe[0];
	for(auto descriptor : {input_pipe[0], input_pipe[1], output_pipe[0], output_pipe[1]}) {
		fcntl(descriptor, F_SETFD, FD_CLOEXEC);
	}
	fcntl(output_handle_, F_SETFL, O_NONBLOCK);
	posix_spawn_file_actions_t actions;
	posix_spawn_file_actions_init(&actions);
	posix_spawn_file_actions_adddup2(&actions, input_pipe[0], STDIN_FILENO);
	posix_spawn_file_actions_adddup2(&actions, output_pipe[1], STDOUT_FILENO);
	posix_spawn_file_actions_adddup2(&actions, output_pipe[1], STDERR_FILENO);
	const auto owner = std::to_string(getpid());
	std::vector<std::string> arguments{executable, script, owner, MAXFORGE_PACKAGE_VERSION, configuration};
	std::vector<char*> pointers;
	for(auto &argument : arguments) pointers.push_back(argument.data());
	pointers.push_back(nullptr);
	posix_spawnattr_t attributes;
	posix_spawnattr_init(&attributes);
	posix_spawnattr_setflags(&attributes, POSIX_SPAWN_CLOEXEC_DEFAULT);
	const auto error = posix_spawn(&process_, executable.c_str(), &actions, &attributes, pointers.data(), environ);
	posix_spawnattr_destroy(&attributes);
	posix_spawn_file_actions_destroy(&actions);
	::close(input_pipe[0]); ::close(output_pipe[1]);
	if(error != 0) throw std::runtime_error("Cannot launch Max's Node runtime: " + std::string{strerror(error)});
#endif
	started_ = true;
}

void managed_service::read_output() {
	char buffer[4096];
#ifdef _WIN32
	DWORD available{}, count{}, exit_code{};
	const bool exited = !GetExitCodeProcess(process_, &exit_code) || exit_code != STILL_ACTIVE;
	while(PeekNamedPipe(output_handle_, nullptr, 0, nullptr, &available, nullptr) && 0 < available) {
		if(!ReadFile(output_handle_, buffer, sizeof(buffer), &count, nullptr)) break;
		output_.append(buffer, count);
#else
	int status{};
	const bool exited = waitpid(process_, &status, WNOHANG) == process_;
	if(exited) process_ = -1;
	for(;;) {
		const auto count = read(output_handle_, buffer, sizeof(buffer));
		if(count <= 0) break;
		output_.append(buffer, (std::size_t)count);
#endif
		if(16384 < output_.size()) throw std::runtime_error("Invalid bundled service startup output");
	}
	if(exited) throw std::runtime_error("Bundled service exited; restart Max. " + output_);
	const auto newline = output_.find('\n');
	if(websocket_port_ == 0 && newline != std::string::npos) {
		std::istringstream message{output_.substr(0, newline)};
		std::string marker;
		int http_port{};
		message >> marker >> websocket_port_ >> http_port >> token_;
		if(marker != "MAXFORGE_READY" || websocket_port_ < 1 || 65535 < websocket_port_ ||
			http_port < 1 || 65535 < http_port || token_.size() != 64 ||
			token_.find_first_not_of("0123456789abcdef") != std::string::npos) {
			throw std::runtime_error("Bundled service failed: " + output_);
		}
		output_.clear();
	}
}

}
