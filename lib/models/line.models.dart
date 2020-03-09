import 'package:flutter/material.dart';
import 'package:flutter_web_amcharts/utils.dart';

class LineChartConfig {
  bool isDark;
  bool useCursor;
  bool zoomOutButton;
  List<ChartData> data;
  ChartXAxes xAxes;
  ChartYAxes yAxes;
  List<ChartSeries> series;
  ChartLegend legend;
  ChartScrollbar scrollbarX;
  ChartScrollbar scrollbarY;

  LineChartConfig(
      {this.isDark,
      this.useCursor,
      this.zoomOutButton,
      this.data,
      this.xAxes,
      this.yAxes,
      this.series,
      this.legend,
      this.scrollbarX,
      this.scrollbarY});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isDark'] = this.isDark;
    data['useCursor'] = this.useCursor;
    data['zoomOutButton'] = this.zoomOutButton;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.xAxes != null) {
      data['xAxes'] = this.xAxes.toJson();
    }
    if (this.yAxes != null) {
      data['yAxes'] = this.yAxes.toJson();
    }
    if (this.series != null) {
      data['series'] = this.series.map((v) => v.toJson()).toList();
    }
    if (this.legend != null) {
      data['legend'] = this.legend.toJson();
    }
    if (this.scrollbarX != null) {
      data['scrollbarX'] = this.scrollbarX.toJson();
    }
    if (this.scrollbarY != null) {
      data['scrollbarY'] = this.scrollbarY.toJson();
    }
    return data;
  }
}

abstract class ChartData {
  Map<String, dynamic> toJson();
}

class ChartXAxes {
  String type;
  ChartAxisDataFields dataFields;
  ChartTitle title;

  ChartXAxes({this.type, this.dataFields, this.title});

  ChartXAxes.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    dataFields = json['dataFields'] != null
        ? new ChartAxisDataFields.fromJson(json['dataFields'])
        : null;
    title = json['title'] != null ? new ChartTitle.fromJson(json['title']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.dataFields != null) {
      data['dataFields'] = this.dataFields.toJson();
    }
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    return data;
  }
}

class ChartTitle {
  String text;

  ChartTitle({this.text});

  ChartTitle.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class ChartYAxes {
  ChartTitle title;

  ChartYAxes({this.title});

  ChartYAxes.fromJson(Map<String, dynamic> json) {
    title = json['title'] != null ? new ChartTitle.fromJson(json['title']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    return data;
  }
}

class ChartSeries {
  String id;
  String name;
  String type;
  Color stroke;
  dynamic fill;
  int strokeWidth;
  ChartDataFields dataFields;

  ChartSeries(
      {this.id,
      this.name,
      this.type,
      this.stroke,
      this.fill,
      this.strokeWidth,
      this.dataFields});

  ChartSeries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    stroke = json['stroke'];
    fill = json['fill'];
    strokeWidth = json['strokeWidth'];
    dataFields = json['dataFields'] != null
        ? new ChartDataFields.fromJson(json['dataFields'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;

    if (this.stroke != null) {
      data['stroke'] = Utils.toRGBA(this.stroke);
    }

    if (this.fill.runtimeType == Color ||
        this.fill.runtimeType == MaterialColor) {
      data['fill'] = Utils.toRGBA(this.fill);
    } else if (this.fill.runtimeType == LinearGradient) {
      data['fill'] = Utils.gradientToJSon(this.fill);
    } 

    data['strokeWidth'] = this.strokeWidth;
    if (this.dataFields != null) {
      data['dataFields'] = this.dataFields.toJson();
    }
    return data;
  }
}

class ChartAxisDataFields {
  String category;

  ChartAxisDataFields({this.category});

  ChartAxisDataFields.fromJson(Map<String, dynamic> json) {
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    return data;
  }
}


class ChartDataFields {
  String valueY;
  String categoryX;

  ChartDataFields({this.valueY, this.categoryX});

  ChartDataFields.fromJson(Map<String, dynamic> json) {
    valueY = json['valueY'];
    categoryX = json['categoryX'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valueY'] = this.valueY;
    data['categoryX'] = this.categoryX;
    return data;
  }
}

class ChartLegend {
  bool active;
  String position;
  bool scrollable;
  bool highlightOnHover;

  ChartLegend({this.active, this.position, this.scrollable, this.highlightOnHover});

  ChartLegend.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    position = json['position'];
    scrollable = json['scrollable'];
    highlightOnHover = json['highlightOnHover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['position'] = this.position;
    data['scrollable'] = this.scrollable;
    data['highlightOnHover'] = this.highlightOnHover;
    return data;
  }
}

class ChartScrollbar {
  bool enabled;
  String seriesId;

  ChartScrollbar({this.enabled, this.seriesId});

  ChartScrollbar.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    seriesId = json['seriesId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this.enabled;
    data['seriesId'] = this.seriesId;
    return data;
  }
}
