import 'dart:collection';

import 'package:fl_chart/fl_chart.dart';
class LineChartData{
  late List<LineChartBarData> lines;
  late LineChartBarData netSpeedLine;
  late Queue<FlSpot> speed ;
  late List<FlSpot> sp;

  get spots => null;
  List<FlSpot> getSpots(){
    
    return spots.toList();
  }
}
