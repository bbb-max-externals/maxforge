#pragma once

#include <chrono>
#include <string>

namespace maxforge {

// Shared by every object in this loaded external. It is not owned by a patcher.
class managed_service {
public:
	static auto instance() -> managed_service&;
	~managed_service();
	managed_service(const managed_service&) = delete;
	auto operator=(const managed_service&) -> managed_service& = delete;
	auto ready(const std::string &configuration) -> bool;
	auto websocket_port() const -> int { return websocket_port_; }
	auto token() const -> const std::string& { return token_; }

private:
	managed_service() = default;
	void start(const std::string &configuration);
	void close();
	void read_output();
	bool started_{};
	int websocket_port_{};
	std::string token_;
	std::string output_;
	std::string configuration_;
	std::string error_;
	std::chrono::steady_clock::time_point started_at_;
#ifdef _WIN32
	void *process_{};
	void *input_{};
	void *output_handle_{};
#else
	int process_{-1};
	int input_{-1};
	int output_handle_{-1};
#endif
};

}
