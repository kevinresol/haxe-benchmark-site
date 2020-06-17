package data;

private typedef SeriesObject = {
	name:String,
	dates:Array<Date>,
	values:Array<Float>,
}

@:forward
abstract DataSeries(SeriesObject) from SeriesObject {
	public function slice(start:Int, end:Int):SeriesObject {
		return {
			name: this.name,
			dates: this.dates.slice(start, end),
			values: this.values.slice(start, end),
		}
	}
	
	public static function time(list:List<Data>, target:Target):DataSeries {
		var dates = [];
		var values = [];
		for (entry in list)
			for (t in entry.targets)
				if (t.name == target)
					switch t.time {
						case null:
						case v:
							dates.push(entry.date);
							values.push(v);
					}

		return {name: target, dates: dates, values: values}
	}

	public static function compileTime(list:List<Data>, target:Target):DataSeries {
		var dates = [];
		var values = [];
		for (entry in list)
			for (t in entry.targets)
				if (t.name == target)
					switch t.compileTime {
						case null:
						case v:
							dates.push(entry.date);
							values.push(v);
					}

		return {name: target, dates: dates, values: values}
	}
}

private typedef SetObject = {
	dates:Array<Date>,
	series:Map<String, Array<Float>>,
}

@:forward
abstract DataSet(SetObject) from SetObject {
	public static function merge(series:Array<DataSeries>):DataSet {
		// TODO: optimize this
		var times = [];
		var map = new Map();
		for (s in series)
			for (date in s.dates) {
				var time = date.getTime();
				if (times.indexOf(time) == -1)
					times.push(time);
			}

		times.sort(Reflect.compare);

		for (s in series) {
			var values = [];
			var s_times = [for (date in s.dates) date.getTime()];
			for (time in times)
				switch s_times.indexOf(time) {
					case -1:
						values.push(null);
					case i:
						values.push(s.values[i]);
				}
			map[s.name] = values;
		}

		return {dates: [for (time in times) Date.fromTime(time)], series: map}
	}
}
