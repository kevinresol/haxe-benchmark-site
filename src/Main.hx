package;

import ui.*;
import data.Data;
import data.DataSeries;
import coconut.Ui.hxx;
import tink.Anon.merge;

class Main extends View {
	@:attr var data:BenchmarkData;

	@:state var active:ObservableMap<Target, Bool> = new ObservableMap([for (target in Target.list()) target => true]);

	// @formatter:off
	function render() '
		<div style=${{width: '100vw', height: '100vh'}}>
			<switch ${data.data}>
				<case ${Loading}>
					Loading
				<case ${Failed(e)}>
					${e.message}
				<case ${Done(list)}>
					<select onchange=${e -> data.version = cast e.src.value}>
						<for ${v in HaxeVersion.list()}>
							<option value=${v} selected=${data.version == v}>${v}</option>
						</for>
					</select>
					<for ${target in Target.list()}>
						<button onclick=${active.set(target, !active.get(target))}>${target}</button>
					</for>
					<Chart config=${{
						type: 'line',
						data: {
							var series = [];
							for(target in active.keys()) if(active.get(target))
								series.push(DataSeries.time(list, target).slice(-20, -1));
							var dataset = DataSet.merge(series);
							
							{
								labels: [for(date in dataset.dates) date.toString()],
								datasets: [for(target in dataset.series.keys()) {
									label: target,
									backgroundColor: 'rgba(0, 0, 0, 0)',
									borderColor: 'rgba(${Std.random(255)}, ${Std.random(255)}, ${Std.random(255)}, 1)',
									data: dataset.series.get(target),
								}],
							}
						},
					}}/>
					
			
			</switch>
		</div>
	';
	// @formatter:on
	static function main() {
		var data = new BenchmarkData({name: 'formatter_noio', version: Haxe4});
		data.observables.data.getNext(v -> v.toOption()).handle(list -> trace([for (v in list) merge(v, targets = [for (t in v.targets) t])]));
		Renderer.mountInto(document.getElementById('app'), hxx('<Main data=${data}/>'));
	}
}
