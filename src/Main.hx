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
					<div>
						<Dropdown
							value=${data.version}
							options=${HaxeVersion.list()}
						/>
					</div>
					<div>
						<for ${target in Target.list()}>
							<div style=${{margin: '4px'}} class="button is-primary is-small ${active.get(target) ? 'is-active' : 'is-outlined'}" onclick=${active.set(target, !active.get(target))}>${target}</div>
						</for>
					</div>
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
									borderColor: (cast target:Target).color(),
									data: dataset.series.get(target),
								}],
							}
						},
						options: {
							animation: false,
						}
					}}/>
					
			
			</switch>
		</div>
	';
	
	function dropdown(attrs:{}) '
		<div class="dropdown">
			<div class="dropdown-trigger">
				<button class="button" aria-haspopup="true" aria-controls="dropdown-menu">
				<span>${data.version}</span>
				<span class="icon is-small">
					<i class="fas fa-angle-down" aria-hidden="true"></i>
				</span>
				</button>
			</div>
			<div class="dropdown-menu" id="dropdown-menu" role="menu">
				<div class="dropdown-content">
					<for ${v in HaxeVersion.list()}>
						<a href="#" class="dropdown-item ${data.version == v ? 'is-active' : ''}" onclick=${data.version = v}>${v}</a>
					</for>
				</div>
			</div>
		</div>
	';
	
	// @formatter:on
	static function main() {
		var data = new BenchmarkData({name: 'formatter_noio', version: Haxe4});
		Renderer.mountInto(document.getElementById('app'), hxx('<Main data=${data}/>'));
	}
}

class Dropdown extends View {
	@:controlled var value:HaxeVersion;
	@:attr var options:List<HaxeVersion>;
	@:state var open:Bool = false;

	// @formatter:off
	function render() '
		<div class="dropdown ${open ? 'is-active' : ''}">
			<div class="dropdown-trigger">
				<button class="button is-small" aria-haspopup="true" aria-controls="dropdown-menu" onclick=${open = true}>
				<span>${value}</span>
				<span class="icon is-small">
					<i class="fas fa-angle-down" aria-hidden="true"></i>
				</span>
				</button>
			</div>
			<div class="dropdown-menu" id="dropdown-menu" role="menu">
				<div class="dropdown-content">
					<for ${v in options}>
						<a class="dropdown-item ${value == v ? 'is-active' : ''}" onclick=${() -> {open = false; value = v;} }>${v}</a>
					</for>
				</div>
			</div>
		</div>
	';
	
	// @formatter:on
}
