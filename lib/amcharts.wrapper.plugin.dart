@JS()
library amchart_wrapper_plugin;

import 'package:js/js.dart';

// ignore: missing_js_lib_annotation
@JS('amchartsWrapperPlugin')
class AmChartJSWrapperPlugin {
  external factory AmChartJSWrapperPlugin();
  external void showPieChart(String chartId, String config);
  external void showLineChart(String chartId, String config);
}