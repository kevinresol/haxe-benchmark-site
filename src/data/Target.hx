package data;

enum abstract Target(String) to String {
	var Cpp = "C++";
	var CppGcGen = "C++ (GC Gen)";
	var Cppia = "Cppia";
	var Node = "NodeJS";
	var NodeEs6 = "NodeJS (ES6)";
	var Java = "Java";
	var Jvm = "JVM";
	var HashLink = "HashLink";
	var HashLinkC = "HashLink/C";
	var HashLinkImmix = "HashLink Immix";
	var HashLinkCImmix = "HashLink/C Immix";
	var Cs = "C#";
	var Php = "PHP";
	var Python = "Python";
	var Eval = "Eval";
	var Lua = "Lua";
	var LuaJit = "Luajit";
	var Neko = "Neko";

	public static inline function list()
		return ListEnumAbstract.list(Target);

	public function color():String {
		return switch (cast this : Target) {
			case Cpp: '#e6194B';
			case CppGcGen: '#dcbeff';
			case Cppia: '#9A6324';
			case Node: '#3cb44b';
			case NodeEs6: '#ffe119';
			case Java: '#4363d8';
			case Jvm: '#f58231';
			case HashLink: '#911eb4';
			case HashLinkC: '#42d4f4';
			case HashLinkImmix: '#fffac8';
			case HashLinkCImmix: '#808000';
			case Cs: '#f032e6';
			case Php: '#bfef45';
			case Python: '#fabed4';
			case Eval: '#469990';
			case Lua: '#800000';
			case LuaJit: '#ffd8b1';
			case Neko: '#aaffc3';
		}
		// colors for new targets:
		// #000075
		// #a9a9a9
	}
}
