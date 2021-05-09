import 'package:fl_chart/fl_chart.dart';
import "package:flutter/material.dart";

class PieData extends PieChartSectionData {

  PieData(double _value, Color _color, double _radius) : super(value: _value,
      title: _value.toStringAsFixed(2) + "%",
      color: _color,
      radius: _radius);

  @override
  TextStyle get titleStyle {
    return TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

}
