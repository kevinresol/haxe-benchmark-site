package data;

enum abstract HaxeVersion(String) to String to tink.Stringly {
	var Haxe3 = 'haxe3';
	var Haxe4 = 'haxe4';
	var Nightly = 'haxe-nightly';
	
	public static inline function list()
		return ListEnumAbstract.list(HaxeVersion);

}