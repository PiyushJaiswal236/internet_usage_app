import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internet_speed_meter/internet_speed_meter.dart';
import 'package:internet_usage_app/widgets/SpeedLineGraph.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late String _currentSpeed;

  void init() async {
    try {
      _internetSpeedMeterPlugin.getCurrentInternetSpeed().listen((event) {
        setState(() {
          _currentSpeed = event;
        });
        print('Event: $event');
      });
    } on PlatformException {
      _currentSpeed = 'Failed to get currentSpeed.';
    }
  }

  final InternetSpeedMeter _internetSpeedMeterPlugin = InternetSpeedMeter();

  @override
  void initState() {
    super.initState();
    _currentSpeed = '';
    //init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin Example App'),
      ),
      body: const Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              NetSpeedLineGraph(),
        ]),
      ),
    );
  }
}

