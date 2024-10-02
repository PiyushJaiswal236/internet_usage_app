import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_usage_app/pages/data_stats.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: DataStatsPage(),);
  }
}
