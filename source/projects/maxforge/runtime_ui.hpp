#pragma once

#include <stdexcept>
#include <string>
#include <variant>
#include <vector>

namespace maxforge::runtime_ui {

using atom = std::variant<double, std::string>;
struct error : std::runtime_error {

	std::string code;
	error(const std::string &code_value, const std::string &message)
	: std::runtime_error{message}, code{code_value} {}
};

auto supported_messages(const std::string &class_name) -> std::vector<std::string>;
void validate_message(const std::string &class_name, const std::string &selector,
	const std::vector<atom> &atoms);

}
