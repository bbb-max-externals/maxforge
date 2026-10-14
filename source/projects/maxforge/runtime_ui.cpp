#include "runtime_ui.hpp"

#include <algorithm>
#include <cmath>
#include <unordered_set>

namespace maxforge::runtime_ui {

auto supported_messages(const std::string &class_name) -> std::vector<std::string> {
	static const std::unordered_set<std::string> scalar{
		"number", "flonum", "toggle", "slider", "dial", "pictctrl", "gain~",
		"live.toggle", "live.dial", "live.slider", "live.numbox", "live.gain~",
		"tab", "live.tab", "umenu", "live.menu"
	};
	if(scalar.count(class_name)) return {"bang", "int", "float", "set"};
	if(class_name == "button" || class_name == "live.button") {
		return {"bang", "int", "float", "list"};
	}
	if(class_name == "textbutton" || class_name == "live.text") {
		return {"bang", "int", "float", "set", "symbol", "setsymbol"};
	}
	if(class_name == "rslider" || class_name == "pictslider") {
		return {"bang", "int", "float", "list", "set"};
	}
	if(class_name == "multislider") return {"bang", "list", "set", "setlist"};
	if(class_name == "kslider") return {"bang", "int", "float", "set", "clear"};
	if(class_name == "radiogroup") return {"bang", "int", "list", "set"};
	if(class_name == "matrixctrl") return {"bang", "list", "set", "clear"};
	if(class_name == "incdec") return {"bang", "int", "float", "set", "inc", "dec"};
	// Editing message text is structural. Runtime triggering does not change it.
	if(class_name == "message") return {"bang"};
	return {};
}

void validate_message(const std::string &class_name, const std::string &selector,
	const std::vector<atom> &atoms)
{
	const auto supported = supported_messages(class_name);
	if(supported.empty()) throw error{"UNSUPPORTED_CLASS", "Unsupported runtime UI class: " + class_name};
	if(std::find(supported.begin(), supported.end(), selector) == supported.end()) {
		throw error{"UNSUPPORTED_MESSAGE", "Unsupported " + class_name + " message: " + selector};
	}
	const auto invalid = [](const std::string &message) {
		throw error{"INVALID_ARGUMENT", message};
	};
	if(256 < atoms.size()) invalid("At most 256 atoms are supported");
	if(selector == "bang" || selector == "clear" || selector == "inc" || selector == "dec") {
		if(!atoms.empty()) invalid(selector + " takes no atoms");
		return;
	}
	if(selector == "symbol" || selector == "setsymbol") {
		if(atoms.size() != 1 || !std::holds_alternative<std::string>(atoms[0])) {
			invalid(selector + " requires one symbol");
		}
		return;
	}
	if(atoms.empty()) invalid("Message requires atoms");
	// button accepts lists of symbols too; all other exposed messages are numeric.
	const auto button_list = selector == "list" &&
		(class_name == "button" || class_name == "live.button");
	for(const auto &value : atoms) {
		if(!std::holds_alternative<double>(value)) {
			if(button_list) continue;
			invalid("This message requires numeric atoms");
		}
		const auto number = std::get<double>(value);
		if(!std::isfinite(number) || 9007199254740991.0 < std::abs(number)) {
			invalid("Number is not finite or outside the safe integer range");
		}
		if(selector == "int" && std::trunc(number) != number) invalid("int requires an integer");
	}
	if(button_list) return;
	if(selector == "int" || selector == "float") {
		if(atoms.size() != 1) invalid("int/float require exactly one atom");
	} else if(class_name == "matrixctrl") {
		if(atoms.size() % 3 != 0) invalid("matrixctrl requires column,row,value triplets");
		for(const auto &value : atoms) {
			const auto number = std::get<double>(value);
			if(number < 0 || std::trunc(number) != number) invalid("matrixctrl requires nonnegative integers");
		}
	} else if(class_name == "multislider") {
		if(selector == "set") {
			if(atoms.size() != 2) invalid("multislider set requires 1-based index,value");
			const auto index = std::get<double>(atoms[0]);
			if(index < 1 || std::trunc(index) != index) invalid("multislider index must be a positive integer");
		}
	} else if(class_name == "rslider" || class_name == "pictslider") {
		if(atoms.size() != 2) invalid("Range/XY list and set require exactly two values");
	} else if(class_name != "radiogroup" && atoms.size() != 1) {
		invalid("Message requires exactly one atom");
	}
	if(class_name == "toggle" || class_name == "live.toggle" ||
		class_name == "textbutton" || class_name == "live.text") {
		const auto number = std::get<double>(atoms[0]);
		if(number != 0 && number != 1) invalid("Use an explicit 0 or 1 state");
	}
	if(class_name == "kslider") {
		const auto note = std::get<double>(atoms[0]);
		if(note < 0 || 127 < note || std::trunc(note) != note) invalid("MIDI note must be an integer in 0..127");
	}
}

}
