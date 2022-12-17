// ignore_for_file: prefer_const_constructors

import 'package:covid_19_tracker/widgets/custom_row.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

// color code
  final colorList = [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: height * 0.01),
              PieChart(
                dataMap: const {
                  'Total': 210,
                  "Recovered": 200,
                  "Death": 10,
                },
                chartRadius: width / 2.3,
                animationDuration: Duration(milliseconds: 1200),
                colorList: colorList,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:height*0.06),
                child: Card(
                  child: Column(children: [
                    customRow(title: "Total", value: "200"),
                    customRow(title: "Total", value: "200"),
                    customRow(title: "Total", value: "200"),
                  ],),
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF1aa260),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: Text("Track Contries")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}