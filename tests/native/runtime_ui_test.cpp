#include "runtime_ui.hpp"
#include <iostream>
#include <limits>

using maxforge::runtime_ui::validate_message;

int main() {
	try {
		for(const auto *name : {"number", "flonum", "toggle", "slider", "dial", "pictctrl", "gain~",
			"live.toggle", "live.dial", "live.slider", "live.numbox", "live.gain~", "tab", "live.tab", "umenu", "live.menu",
			"textbutton", "live.text", "kslider", "incdec"}) {
			validate_message(name, "int", {1.0});
			validate_message(name, "set", {0.0});
			validate_message(name, "bang", {});
		}
		validate_message("rslider", "list", {1.0, 2.0});
		validate_message("pictslider", "set", {1.0, 2.0});
		validate_message("multislider", "setlist", {0.1, 0.2, 0.3});
		validate_message("matrixctrl", "set", {0.0, 1.0, 1.0, 2.0, 3.0, 0.0});
		validate_message("radiogroup", "list", {0.0, 1.0});
		validate_message("button", "list", {std::string{"hello"}, 1.0});
		validate_message("live.button", "bang", {});
		validate_message("message", "bang", {});
		int rejected{};
		const auto reject = [&rejected](const std::string &name, const std::string &selector,
			const std::vector<maxforge::runtime_ui::atom> &atoms) {
			try { validate_message(name, selector, atoms); }
			catch(const maxforge::runtime_ui::error &) { rejected++; return; }
			throw std::runtime_error{"Accepted invalid " + name + " " + selector};
		};
		reject("thispatcher", "script", {std::string{"delete"}});
		reject("message", "set", {1.0});
		reject("number", "int", {0.5});
		reject("number", "float", {std::numeric_limits<double>::infinity()});
		reject("number", "set", {std::string{"text"}});
		reject("toggle", "int", {2.0});
		reject("button", "bang", {1.0});
		reject("rslider", "list", {1.0});
		reject("matrixctrl", "set", {0.0, 1.0});
		reject("matrixctrl", "list", {-1.0, 1.0, 0.0});
		reject("multislider", "set", {0.0, 1.0});
		reject("kslider", "int", {128.0});
		std::cout << "Runtime UI profiles and " << rejected << " rejection cases passed\n";
		return 0;
	} catch(const std::exception &exception) {
		std::cerr << exception.what() << '\n';
		return 1;
	}
}
