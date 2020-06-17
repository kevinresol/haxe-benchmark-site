package data;

typedef Data = {
	final date:HaxeDate;
	final haxeVersion:String;
	final targets:List<{
		final name:Target;
		final ?status:Int;
		final compileTime:Null<Float>;
		final time:Float;
	}>;
}


@:forward
abstract HaxeDate(Date) to Date {
	inline function new(v) this = v;
	
	@:to inline function toRepresentation():tink.json.Representation<String>
		return new tink.json.Representation(this.toString());
	
	@:from static inline function fromRepresentation(v:tink.json.Representation<String>):HaxeDate
		return new HaxeDate(Date.fromString(v.get()));
}

