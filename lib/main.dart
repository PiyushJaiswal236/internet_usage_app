import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:internet_speed_meter/internet_speed_meter.dart';
import 'package:internet_usage_app/pages/home.dart';
import 'package:internet_usage_app/pages/home_page.dart';
import 'package:internet_usage_app/services/database_services.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Home(),
    );
  }
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  runApp(const MyApp());
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,
      // auto start service
      autoStart: true,
      isForegroundMode: true,
      autoStartOnBoot: true,
      //
      // notificationChannelId: 'my_foreground',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
      foregroundServiceTypes: [AndroidForegroundType.dataSync],
    ),
    iosConfiguration: IosConfiguration(),
  );
  await service.startService();
  FlutterBackgroundService().invoke("setAsForeground");
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }
    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        print("${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second} SEE THE TIME BITCH !!");
        service.setForegroundNotificationInfo(title: "HELL YEAH", content: "BITCH FEIN");
      }
    }

    double usage=0.0;
    void insertOnHourChange() {
      final deltaTime =
          DateTime
              .now()
              .add(const Duration(hours: 1))
              .millisecondsSinceEpoch -
              DateTime
                  .now()
                  .millisecondsSinceEpoch;
      Timer(
        Duration(milliseconds: deltaTime),
            () {
          final db = DatabaseServices.instance;
          db.hourlyUsageTable.insertUsageIntoHourlyUsageTable(usage);
          usage = 0.0;
          insertOnHourChange();
        },
      );
    }
    insertOnHourChange();

    InternetSpeedMeter().getCurrentInternetSpeedInBytes().listen((
        currentSpeed) {
      usage += currentSpeed;
      service.invoke("speed_update", {"currentSpeed": currentSpeed});
    });
  }
