import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:internet_speed_meter/internet_speed_meter.dart';
import 'package:internet_usage_app/services/database_services.dart';

class NetSpeedLineGraph extends StatefulWidget {
  const NetSpeedLineGraph({super.key});

  @override
  State<NetSpeedLineGraph> createState() => _NetSpeedLineGraphState();
}

class _NetSpeedLineGraphState extends State<NetSpeedLineGraph> {
  InternetSpeedMeter speedMeter = InternetSpeedMeter();
  final sampleLimit = 60;
  late double currentSpeed;
  var xValue = 0.0;
  var maxSpeed = 0.0;
  var minSpeed = double.maxFinite;
  late double currentTime;

  final service =FlutterBackgroundService();
  List<dynamic>? result;

  List<FlSpot> speedSpots = List.generate(
    60,
    (index) {
      return FlSpot(DateTime.now().millisecondsSinceEpoch.toDouble(), 0.0);
    },
  );

  @override
  void initState()  {
    // setUplListener();
    // _initializeDatabase();

    super.initState();
  }
  Future<void> _initializeDatabase() async {
    final db = DatabaseServices.instance;
    await db.hourlyUsageTable.insertUsageIntoHourlyUsageTable(150);
    final data = await db.hourlyUsageTable.getHourlyUsageForDateRange(
      DateTime.now().subtract(const Duration(days: 1)),
      DateTime.now().add(const Duration(days: 1)),
    );
    setState(() {
      result = data;
    });

  }


  void setUplListener() async{
    currentSpeed=0.0;
    speedMeter.getCurrentInternetSpeedInBytes().listen(
      (speed) {
        setState(() {
        currentTime = DateTime.now().millisecondsSinceEpoch.toDouble();
        currentSpeed = speed.toDouble().ceilToDouble();
        });
        if (speedSpots.length >= sampleLimit) {
          speedSpots.removeAt(0);
        }
        setState(() {
          if (minSpeed > currentSpeed) {
            minSpeed = currentSpeed;
          }
          if (maxSpeed < currentSpeed) {
            maxSpeed = currentSpeed;
          }
          speedSpots.add(FlSpot(currentTime, currentSpeed));
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: AspectRatio(
            aspectRatio: 2 / 1,
            child: LineChart(
              LineChartData(
                  borderData: FlBorderData(show: false),
                  backgroundColor: const Color.fromRGBO(6, 26, 49, 1.0),
                  gridData: const FlGridData(show: false),
                  maxY: maxSpeed * 1.25,
                  minY: 0,
                  maxX: speedSpots.last.x,
                  minX: speedSpots.first.x,
                  lineBarsData: [
                    speedLine(speedSpots),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 30,
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          value /= 1024;
                          String speedUnit;
                          double speedValue;
                          String speedSideTitle;
                          if (value >= 1024) {
                            speedSideTitle = '${(value / 1024).toInt()}MB';
                            speedUnit = 'MBps';
                            speedValue = double.parse(value.toString()) / 1024;
                          } else {
                            speedSideTitle = '${value.toInt()}KB';
                          }
                          // Return the formatted speed with unit
                          return SideTitleWidget(
                              axisSide: meta.axisSide,
                              // fitInside: SideTitleFitInsideData(
                              //     enabled: enabled,
                              //     axisPosition: axisPosition,
                              //     parentAxisSize: parentAxisSize,
                              //     distanceFromEdge: distanceFromEdge),
                              child: Text(
                                speedSideTitle,
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.black),
                              ));
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  )),
            ),
          ),
        ),
        // Text(currentSpeed.toString()??"cspeed"),
        StreamBuilder(
            stream: service.on("speed_update"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                final data= snapshot.data;
                final speed=data['currentSpeed'];
                return Text(speed.toString());
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return CircularProgressIndicator();
              }
            }),
        Text(speedSpots.length.toString()),
        Text(result.toString()??"HellNo"),
      ],
    );
  }

  LineChartBarData speedLine(List<FlSpot> spots) {
    return LineChartBarData(
        dotData: const FlDotData(show: false),
        spots: spots,
        gradient: LinearGradient(
            colors: [Colors.blue, Colors.blue.withOpacity(0.05)],
            end: Alignment.centerLeft,
            begin: Alignment.centerRight));
  }
}
