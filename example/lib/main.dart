import 'package:flutter/material.dart';
import 'package:flutter_web_amcharts/models.dart';
import 'package:flutter_web_amcharts/pie.chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter_web_amcharts'),
        ),
        body: PieChart(
          id: 'my-piechart',
          config: PieChartConfig(
            innerRadius: 40,
            onHoverSettings: ChartSettings(
              fillOpacity: 1,
              shiftRadius: 0.05
            ),
            legend: ChartLegend(
              active: true
            ),
            pieSeries: ChartPieSeries(
              ticks: ChartTicks(
                template: ChartTicksTemplate(disabled: true)
              ),
              labels: ChartLabels(
                template: ChartLabelTemplate(disabled: true)
              )
            ),
            data: [
              ChartData(
                category: 'Renda Fixa',
                value: 10.0,
                color: Colors.redAccent
              ),
              ChartData(
                category: 'Multimercado',
                value: 15.0,
                color: Colors.blueAccent
              ),
              ChartData(
                color: Colors.deepOrangeAccent,
                value: 5.0,
                category: 'Renda Variável'
              )
            ]
          ),
        )
      ),
    );
  }
}
