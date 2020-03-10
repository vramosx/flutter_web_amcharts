import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_web_amcharts/charts/line.chart.dart';
import 'package:flutter_web_amcharts/models/line.models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var chartData = <LineChartData>[];

  double randomNumber() {
    var rng = new Random();
    return rng.nextDouble();
  }

  @override
  void initState() {
    super.initState();
    generateData();
  }

  generateData() {
    for (var i = 1; i < 31; i++) {
      chartData.add(LineChartData(
          category: '$i/03/2020',
          cdi: randomNumber(),
          ibov: randomNumber(),
          poup: randomNumber()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('flutter_web_amcharts'),
          ),
          body: LineChart(
            id: 'line-chart',
            config: LineChartConfig(
                data: chartData,
                legend: ChartLegend(
                    active: true,
                    position: ChartLegendPosition.right,
                    scrollable: true,
                    highlightOnHover: true),
                scrollbarX:
                    ChartScrollbar(enabled: true, seriesId: 'cdi-series'),
                series: [
                  ChartSeries(
                      dataFields:
                          ChartDataFields(categoryX: 'category', valueY: 'cdi'),
                      name: 'CDI',
                      strokeWidth: 2,
                      stroke: Colors.redAccent.withOpacity(0.5),
                      id: 'cdi-series'),
                  ChartSeries(
                    dataFields:
                        ChartDataFields(categoryX: 'category', valueY: 'ibov'),
                    name: 'IBOV',
                    strokeWidth: 2,
                    stroke: Colors.blueAccent.withOpacity(0.5),
                    id: 'ibov-series',
                  ),
                  ChartSeries(
                    dataFields:
                        ChartDataFields(categoryX: 'category', valueY: 'poup'),
                    bullet: ChartBullet(
                        circle: ChartBulletCircle(
                            radius: 2, strokeWidth: 0, fill: Colors.white),
                        tooltipText: '{cdi}%'),
                    tooltip: ChartTooltip(
                        background: ChartTooltipBackground(
                            cornerRadius: 5,
                            strokeOpacity: 0,
                            fill: Colors.black38)),
                    name: 'Poupança',
                    strokeWidth: 2,
                    stroke: Colors.deepOrangeAccent.withOpacity(0.5),
                    id: 'poup-series',
                  ),
                ],
                xAxes: ChartXAxes(type: 'category'),
                yAxes: ChartYAxes()),
          )),
    );
  }
}

class LineChartData extends ChartData {
  String category;
  double cdi;
  double ibov;
  double poup;

  LineChartData({this.category, this.cdi, this.ibov, this.poup});

  @override
  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();

    json['category'] = category;
    json['cdi'] = cdi;
    json['ibov'] = ibov;
    json['poup'] = poup;

    return json;
  }
}
