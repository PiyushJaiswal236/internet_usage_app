import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_usage_app/utils/clippers.dart';
import 'package:internet_usage_app/widgets/custom_sliver_list.dart';

class DataStatsPage extends StatefulWidget {
  const DataStatsPage({super.key});

  @override
  State<DataStatsPage> createState() => _DataStatsPageState();
}

class _DataStatsPageState extends State<DataStatsPage> {
  double expanHei = 250;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverPersistentHeader(
        pinned: true,
        delegate: CustomSiverAppBar(expandedHeight: expanHei),
      ),
      SliverList(delegate: CustomSliverList((context, index) {

      },)),
      // SliverAppBar(
      //   expandedHeight: 350,
      //   floating: true,
      //   flexibleSpace: FlexibleSpaceBar(
      //     title: AppBar(
      //       backgroundColor: Colors.transparent,
      //       title: Text(
      //         'Data Usage',
      //         style: TextStyle(color: Colors.white),
      //       ),
      //       centerTitle: true,
      //       leading: Container(
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(25),
      //             color: Colors.white.withOpacity(0.15)),
      //         // color: Colors.grey.withOpacity(0.5),
      //         child: Icon(
      //           size: 30,
      //           Icons.menu,
      //           color: Colors.white,
      //         ),
      //       ),
      //       actions: [
      //         Container(
      //             height: 56,
      //             width: 56,
      //             decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(25),
      //                 color: Colors.white.withOpacity(0.15)),
      //             child: const Icon(
      //               size: 30,
      //               Icons.dark_mode,
      //               color: Colors.white,
      //             ))
      //       ],
      //     ),
      //     background: Container(
      //       padding: const EdgeInsets.all(20),
      //       decoration: const BoxDecoration(
      //           gradient: LinearGradient(
      //             begin: Alignment.topLeft,
      //             end: Alignment.bottomRight,
      //             colors: [Colors.red, Colors.blue])),
      //       child: Column(
      //         children: [
      //           SizedBox(
      //             height: 15,
      //           ),
      //           AppBar(
      //             backgroundColor: Colors.transparent,
      //             title: Text(
      //               'Data Usage',
      //               style: TextStyle(color: Colors.white),
      //             ),
      //             centerTitle: true,
      //             leading: Container(
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(25),
      //                   color: Colors.white.withOpacity(0.15)),
      //               // color: Colors.grey.withOpacity(0.5),
      //               child: Icon(
      //                 size: 30,
      //                 Icons.menu,
      //                 color: Colors.white,
      //               ),
      //             ),
      //             actions: [
      //               Container(
      //                   height: 56,
      //                   width: 56,
      //                   decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(25),
      //                       color: Colors.white.withOpacity(0.15)),
      //                   child: Icon(
      //                     size: 30,
      //                     Icons.dark_mode,
      //                     color: Colors.white,
      //                   ))
      //             ],
      //           ),
      //           const SizedBox(
      //             height: 25,
      //           ),
      //           Container(
      //             height: 200,
      //             width: 350,
      //             decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(25),
      //                 color: Colors.white),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      SliverToBoxAdapter(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 100),
              UsageDurationSelector(),
              SizedBox(
                height: 23,
              ),
              PhysicalModel(
                color: Colors.white,
                shape: BoxShape.rectangle,
                elevation: 10,
                child: Container(
                  width: double.maxFinite,
                  color: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Usage',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                              color: Color.fromRGBO(61, 61, 61, 1.0)),
                        ),
                      ),
                      AspectRatio(
                          aspectRatio: 2 / 1.5,
                          child: Container(child: Placeholder())),
                      SizedBox(
                        height: 500,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
    ;
  }
}

class UsageDurationSelector extends StatefulWidget {
  const UsageDurationSelector({
    super.key,
  });

  @override
  State<UsageDurationSelector> createState() => _UsageDurationSelectorState();
}

class _UsageDurationSelectorState extends State<UsageDurationSelector> {
  double current =0.5;
  double end = 0.5;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      tween: Tween<double>(begin: current, end: end),
      duration: const Duration(milliseconds: 500),
      builder: (BuildContext context, double? value, Widget? child) {
        return ClipPath(
          clipper: CustomBellCurveClipper(
              BellHeight: 15,
              BellWidth: 90,
              XPosition: value!,
              BorderRadiud: 20),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: child,
        );
      },
      child: Container(
        color: Colors.blue,
        height: 70,
        child:  Stack(
          alignment: Alignment(1, -0.4),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                    end=3/14;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Text',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    end=7/14;
                  }),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Text',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    end = 11/14;
                  }),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Text',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomSiverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  CustomSiverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // print('$shrinkOffset++$expandedHeight');
    return Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
              radius: (2 + ((shrinkOffset / expandedHeight) * 1.2)),
              center: Alignment.bottomRight,
              colors: [
            Color.fromRGBO(251, 85, 152, 1),
            Color.fromRGBO(254, 161, 137, 1),
          ])),
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Positioned(
              right: 20,
              left: 20,
              height: 200,
              bottom: -100 + shrinkOffset,
              child: Container(
                child: Container(
                  color: Colors.grey,
                ),
              )),
          SafeArea(child: buildAppBar(shrinkOffset)),
        ],
      ),
    );
    ;
  }

  Widget buildAppBar(double shrinkOffset) {
    print(expandedHeight);
    return Container(
      alignment: Alignment(1, -0.55),
      padding: EdgeInsets.only(left: 20, right: 20, top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white.withOpacity(0.15)),
            // color: Colors.grey.withOpacity(0.5),
            child: Icon(
              size: 30,
              Icons.menu,
              color: Colors.white,
            ),
          ),
          Text(
            'Data Stats',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white.withOpacity(0.15)),
              child: const Icon(
                size: 30,
                Icons.dark_mode,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;
}
