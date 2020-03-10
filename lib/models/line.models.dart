import 'package:flutter/material.dart';
import 'package:flutter_web_amcharts/utils.dart';

enum ChartTextAlign { start, end, middle }

enum ChartPointerOrientation { horizontal, vertical, left, right, up, down }

enum ChartLegendPosition { left, right, top, bottom }

class ChartBulletCircle {
  int strokeWidth;
  int radius;
  dynamic fill;

  ChartBulletCircle({this.strokeWidth, this.radius, this.fill});

  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();

    json['strokeWidth'] = this.strokeWidth;
    json['radius'] = this.radius;

    if (this.fill.runtimeType == Color ||
        this.fill.runtimeType == MaterialColor) {
      json['fill'] = Utils.toRGBA(this.fill);
    } else if (this.fill.runtimeType == LinearGradient) {
      json['fill'] = Utils.gradientToJSon(this.fill);
    }

    return json;
  }
}

class ChartBullet {
  double onHoverScale;
  String tooltipText;
  ChartBulletCircle circle;

  ChartBullet({this.onHoverScale, this.tooltipText, this.circle});

  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();

    json['type'] = 'circle';
    if (this.tooltipText != null) json['tooltipText'] = this.tooltipText;
    if (this.onHoverScale != null) {
      json['onHover'] = {"scale": this.onHoverScale};
    }

    if (this.circle != null) json['circle'] = this.circle.toJson();

    return json;
  }
}

class ChartTooltipBackground {
  int cornerRadius;
  int strokeOpacity;
  dynamic fill;

  ChartTooltipBackground({this.cornerRadius, this.strokeOpacity, this.fill});

  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();

    if (this.cornerRadius != null) json['cornerRadius'] = this.cornerRadius;
    if (this.strokeOpacity != null) json['strokeOpacity'] = this.strokeOpacity;

    if (this.fill != null) {
      if (this.fill.runtimeType == Color ||
          this.fill.runtimeType == MaterialColor) {
        json['fill'] = Utils.toRGBA(this.fill);
      } else if (this.fill.runtimeType == LinearGradient) {
        json['fill'] = Utils.gradientToJSon(this.fill);
      }
    }

    return json;
  }
}

class ChartTooltipLabel {
  int minWidth;
  int minHeight;
  ChartTextAlign textAlign;
  ChartTextAlign textValign;
  dynamic fill;

  ChartTooltipLabel(
      {this.minWidth,
      this.minHeight,
      this.textAlign,
      this.textValign,
      this.fill});

  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();

    if (this.minWidth != null) json['minWidth'] = this.minWidth;
    if (this.minHeight != null) json['minHeight'] = this.minHeight;
    if (this.textAlign != null)
      json['textAlign'] = Utils.enumToString(this.textAlign);
    if (this.textValign != null)
      json['textValign'] = Utils.enumToString(this.textValign);

    if (this.fill != null) {
      if (this.fill.runtimeType == Color ||
          this.fill.runtimeType == MaterialColor) {
        json['fill'] = Utils.toRGBA(this.fill);
      } else if (this.fill.runtimeType == LinearGradient) {
        json['fill'] = Utils.gradientToJSon(this.fill);
      }
    }

    return json;
  }
}

class ChartTooltip {
  ChartTooltipBackground background;
  ChartTooltipLabel label;
  ChartPointerOrientation pointerOrientation;

  ChartTooltip({this.background, this.label, this.pointerOrientation});

  Map<String, dynamic> toJson() {
    var json = Map<String, dynamic>();

    if (this.background != null) json['background'] = this.background.toJson();
    if (this.label != null) json['label'] = this.label.toJson();
    if (this.pointerOrientation != null)
      json['pointerOrientation'] = Utils.enumToString(this.pointerOrientation);

    return json;
  }
}

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
    title =
        json['title'] != null ? new ChartTitle.fromJson(json['title']) : null;
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
    title =
        json['title'] != null ? new ChartTitle.fromJson(json['title']) : null;
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
  ChartBullet bullet;
  ChartTooltip tooltip;

  ChartSeries(
      {this.id,
      this.name,
      this.type,
      this.stroke,
      this.fill,
      this.strokeWidth,
      this.bullet,
      this.tooltip,
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

    if (this.tooltip != null) {
      data['tooltip'] = this.tooltip.toJson();
    }

    if (this.bullet != null) {
      data['bullet'] = this.bullet.toJson();
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
  ChartLegendPosition position;
  bool scrollable;
  bool highlightOnHover;

  ChartLegend(
      {this.active, this.position, this.scrollable, this.highlightOnHover});

  ChartLegend.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    position = json['position'];
    scrollable = json['scrollable'];
    highlightOnHover = json['highlightOnHover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['position'] = Utils.enumToString(this.position);
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
