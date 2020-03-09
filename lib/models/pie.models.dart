import 'package:flutter/material.dart';
import 'package:flutter_web_amcharts/utils.dart';

class PieChartConfig {
  bool is3D;
  List<ChartData> data;
  String dataSource;
  int innerRadius;
  ChartPieSeries pieSeries;
  ChartSettings defaultSettings;
  ChartSettings onHoverSettings;
  ChartSettings onActiveSettings;
  ChartLegend legend;

  PieChartConfig(
      {this.is3D,
      @required this.data,
      this.dataSource,
      this.innerRadius,
      this.pieSeries,
      this.defaultSettings,
      this.onHoverSettings,
      this.onActiveSettings,
      this.legend});

  PieChartConfig.fromJson(Map<String, dynamic> json) {

    if(is3D != null) {
      is3D = json['is3D'];
    }
    
    if (json['data'] != null) {
      data = new List<ChartData>();
      json['data'].forEach((v) {
        data.add(new ChartData.fromJson(v));
      });
    }

    dataSource = json['dataSource'];
    innerRadius = json['innerRadius'];
    pieSeries = json['pieSeries'] != null
        ? new ChartPieSeries.fromJson(json['pieSeries'])
        : null;
    defaultSettings = json['defaultSettings'] != null
        ? new ChartSettings.fromJson(json['defaultSettings'])
        : null;
    onHoverSettings = json['onHoverSettings'] != null
        ? new ChartSettings.fromJson(json['onHoverSettings'])
        : null;
    onActiveSettings = json['onActiveSettings'] != null
        ? new ChartSettings.fromJson(json['onActiveSettings'])
        : null;
    legend =
        json['legend'] != null ? new ChartLegend.fromJson(json['legend']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is3D'] = this.is3D;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }

    if(dataSource != null) {
      data['dataSource'] = this.dataSource;
    }
    
    if(innerRadius != null) {
      data['innerRadius'] = this.innerRadius;
    }
    
    if (this.pieSeries != null) {
      data['pieSeries'] = this.pieSeries.toJson();
    }
    if (this.defaultSettings != null) {
      data['defaultSettings'] = this.defaultSettings.toJson();
    }
    if (this.onHoverSettings != null) {
      data['onHoverSettings'] = this.onHoverSettings.toJson();
    }
    if (this.onActiveSettings != null) {
      data['onActiveSettings'] = this.onActiveSettings.toJson();
    }
    if (this.legend != null) {
      data['legend'] = this.legend.toJson();
    }
    return data;
  }
}

class ChartData {
  Color color;
  String category;
  double value;

  ChartData({this.color, this.category, this.value});

  ChartData.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    category = json['category'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = Utils.toHex(this.color);
    data['category'] = this.category;
    data['value'] = this.value;
    return data;
  }
}

class ChartPieSeries {
  ChartLabels labels;
  ChartTicks ticks;
  ChartSlices slices;

  ChartPieSeries({this.labels, this.ticks, this.slices});

  ChartPieSeries.fromJson(Map<String, dynamic> json) {
    labels =
        json['labels'] != null ? new ChartLabels.fromJson(json['labels']) : null;
    ticks = json['ticks'] != null ? new ChartTicks.fromJson(json['ticks']) : null;
    slices =
        json['slices'] != null ? new ChartSlices.fromJson(json['slices']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.labels != null) {
      data['labels'] = this.labels.toJson();
    }
    if (this.ticks != null) {
      data['ticks'] = this.ticks.toJson();
    }
    if (this.slices != null) {
      data['slices'] = this.slices.toJson();
    }
    return data;
  }
}

class ChartLabels {
  ChartLabelTemplate template;

  ChartLabels({this.template});

  ChartLabels.fromJson(Map<String, dynamic> json) {
    template = json['template'] != null
        ? new ChartLabelTemplate.fromJson(json['template'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.template != null) {
      data['template'] = this.template.toJson();
    }
    return data;
  }
}

class ChartTicks {
  ChartTicksTemplate template;

  ChartTicks({this.template});

  ChartTicks.fromJson(Map<String, dynamic> json) {
    template = json['template'] != null
        ? new ChartTicksTemplate.fromJson(json['template'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.template != null) {
      data['template'] = this.template.toJson();
    }
    return data;
  }
}

class ChartSlices {
  ChartSlicesTemplate template;

  ChartSlices({this.template});

  ChartSlices.fromJson(Map<String, dynamic> json) {
    template = json['template'] != null
        ? new ChartSlicesTemplate.fromJson(json['template'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.template != null) {
      data['template'] = this.template.toJson();
    }
    return data;
  }
}

class ChartLabelTemplate {
  bool disabled;
  String text;

  ChartLabelTemplate({this.disabled, this.text});

  ChartLabelTemplate.fromJson(Map<String, dynamic> json) {
    disabled = json['disabled'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disabled'] = this.disabled;
    data['text'] = this.text;
    return data;
  }
}

class ChartTicksTemplate {
  bool disabled;

  ChartTicksTemplate({this.disabled});

  ChartTicksTemplate.fromJson(Map<String, dynamic> json) {
    disabled = json['disabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disabled'] = this.disabled;
    return data;
  }
}

class ChartSlicesTemplate {
  double fillOpacity;
  String stroke;
  int strokeWidth;
  double strokeOpacity;
  String tooltipText;

  ChartSlicesTemplate(
      {this.fillOpacity,
      this.stroke,
      this.strokeWidth,
      this.strokeOpacity,
      this.tooltipText});

  ChartSlicesTemplate.fromJson(Map<String, dynamic> json) {
    fillOpacity = json['fillOpacity'];
    stroke = json['stroke'];
    strokeWidth = json['strokeWidth'];
    strokeOpacity = json['strokeOpacity'];
    tooltipText = json['tooltipText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fillOpacity'] = this.fillOpacity;
    data['stroke'] = this.stroke;
    data['strokeWidth'] = this.strokeWidth;
    data['strokeOpacity'] = this.strokeOpacity;
    data['tooltipText'] = this.tooltipText;
    return data;
  }
}

class ChartSettings {
  double scale;
  double shiftRadius;
  double fillOpacity;

  ChartSettings({this.scale, this.shiftRadius, this.fillOpacity});

  ChartSettings.fromJson(Map<String, dynamic> json) {
    scale = json['scale'];
    shiftRadius = json['shiftRadius'];
    fillOpacity = json['fillOpacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scale'] = this.scale;
    data['shiftRadius'] = this.shiftRadius;
    data['fillOpacity'] = this.fillOpacity;
    return data;
  }
}

class ChartLegend {
  bool active;
  ChartValueLabels valueLabels;

  ChartLegend({this.active, this.valueLabels});

  ChartLegend.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    valueLabels = json['valueLabels'] != null
        ? new ChartValueLabels.fromJson(json['valueLabels'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    if (this.valueLabels != null) {
      data['valueLabels'] = this.valueLabels.toJson();
    }
    return data;
  }
}

class ChartValueLabels {
  ChartValueLabelsTemplate template;

  ChartValueLabels({ this.template });

  ChartValueLabels.fromJson(Map<String, dynamic> json) {
    template = json['template'] != null
        ? new ChartValueLabelsTemplate.fromJson(json['valueLabels'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['template'] = this.template.toJson();
    return data;
  }
}

class ChartValueLabelsTemplate {
  String text;

  ChartValueLabelsTemplate({this.text});

  ChartValueLabelsTemplate.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}