package ui;

class Overview extends View {
	static final ROOT = css('
		width: 365px;
		height: 365px;
	');

	@:skipCheck @:state var data:Dynamic = Temp.LINE;

	// @formatter:off
	function render() '
		<div class=${ROOT}>
			<Chart config=${data}/>
		</div>
	';
	
	// @formatter:on
	override function viewDidMount() {
		new haxe.Timer(2000).run = function() {
			trace('toggle');
			data = data == Temp.LINE ? Temp.BAR : Temp.LINE;
		}
	}
}

class Temp {
	public static final BAR = {
		type: 'bar',
		data: {
			labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
			datasets: [
				{
					label: '# of Votes',
					data: [12, 19, 3, 5, 2, 3],
					backgroundColor: [
						'rgba(255, 99, 132, 0.2)',
						'rgba(54, 162, 235, 0.2)',
						'rgba(255, 206, 86, 0.2)',
						'rgba(75, 192, 192, 0.2)',
						'rgba(153, 102, 255, 0.2)',
						'rgba(255, 159, 64, 0.2)'
					],
					borderColor: [
						'rgba(255, 99, 132, 1)',
						'rgba(54, 162, 235, 1)',
						'rgba(255, 206, 86, 1)',
						'rgba(75, 192, 192, 1)',
						'rgba(153, 102, 255, 1)',
						'rgba(255, 159, 64, 1)'
					],
					borderWidth: 1
				}
			]
		},
		options: {
			scales: {
				yAxes: [
					{
						ticks: {
							beginAtZero: true
						}
					}
				]
			}
		}
	}

	public static final LINE = {
		type: 'line',
		data: {
			labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
			datasets: [
				{
					label: 'My First dataset',
					backgroundColor: 'rgba(255, 0, 0, 1)',
					borderColor: 'rgba(255, 0, 0, 1)',
					data: [for (i in 0...7) Math.random() * 200 - 100],
					fill: false,
				},
				{
					label: 'My Second dataset',
					fill: false,
					backgroundColor: 'rgba(0, 0, 255, 1)',
					borderColor: 'rgba(0, 0, 255, 1)',
					data: [for (i in 0...7) Math.random() * 200 - 100],
				}
			]
		},
		options: {
			responsive: true,
			title: {
				display: true,
				text: 'Chart.js Line Chart'
			},
			tooltips: {
				mode: 'index',
				intersect: false,
			},
			hover: {
				mode: 'nearest',
				intersect: true
			},
			scales: {
				xAxes: [
					{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Month'
						}
					}
				],
				yAxes: [
					{
						display: true,
						scaleLabel: {
							display: true,
							labelString: 'Value'
						}
					}
				]
			}
		}
	}
}
