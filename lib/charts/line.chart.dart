import 'dart:convert';
import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_web_amcharts/amcharts.wrapper.plugin.dart';
import 'package:flutter_web_amcharts/models/line.models.dart';

class LineChart extends StatefulWidget {
  final String id;
  final LineChartConfig config;

  LineChart({
    Key key,
    @required this.id,
    @required this.config
  }) : 
  assert(id != null),
  assert(config != null),
  super(key: key);

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  DivElement chartContainer;

  @override
  void initState() { 
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      this.updateChart();
    });
  }


  @override
  void didUpdateWidget(LineChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.config != widget.config) {
      this.updateChart();
    }
  }

  void updateChart() {
    String _id = widget.id;

    var jsonConfig = widget.config.toJson();

    var amchartPlugin = AmChartJSWrapperPlugin();
    amchartPlugin.showLineChart(_id, json.encode(jsonConfig));
  }

  void registerElement() {
    chartContainer = DivElement()
      ..id = widget.id;
    
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        'AmChartLineChart-${widget.id}', (int viewId) => chartContainer);
  }

  @override
  Widget build(BuildContext context) {
    if(chartContainer == null) registerElement();

    return HtmlElementView(viewType: 'AmChartLineChart-${widget.id}');
  }
}