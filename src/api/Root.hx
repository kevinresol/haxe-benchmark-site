package api;

import data.Data;

interface Root {
	@:get('/$benchmarkName/data/$haxeVersion')
	function get(benchmarkName:String, haxeVersion:HaxeVersion):List<Data>;
}
