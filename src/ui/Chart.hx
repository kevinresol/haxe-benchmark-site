package ui;

import js.html.*;
import tink.state.Observable;

class Chart extends View {
	@:attr var config:Config;
	@:ref var element:CanvasElement;

	static final ROOT = css('
		width: 100%;
		height: 100%;
		position: relative;
	');

	static final CANVAS = css('
		width: 100%;
		height: 100%;
	');

	// @formatter:off
	function render() '
		<div class=${ROOT}>
			<canvas width="0" height="0" class=${CANVAS} ref=${element}/>
		</div>
	';
	
	// @formatter:on
	function viewDidMount() {
		var type = config.type;
		var chart = new Native(element.getContext2d(), config);
		untilUnmounted(Observable.auto(() -> config).bind(null, config -> {
			if (config.type != type) {
				type = config.type;
				chart.destroy();
				chart = new Native(element.getContext2d(), config);
			} else {
				chart.data = config.data;
				chart.options = config.options;
				chart.update();
			}
		}));
	}
}

typedef Config = {
	final type:String;
	final data:Data;
	final ?options:Options;
}

@:observable
abstract Data({}) from {} {}

@:observable
abstract Options({}) from {} {}

@:native('Chart')
private extern class Native {
	var type:String;
	var data:Data;
	var options:Options;
	function new(ctx:CanvasRenderingContext2D, config:Config);
	function update():Void;
	function destroy():Void;
}
