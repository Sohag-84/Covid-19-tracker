import 'package:covid_19_tracker/widgets/custom_row.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String name;
  final String image;
  final int totalCases,
      totalRecovered,
      totalDeaths,
      active,
      critical,
      todayRecovered,
      test;

  const DetailsScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.all(height * 0.067),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: height * 0.06),
                      customRow(title: "Cases", value: totalCases.toString()),
                      customRow(title: "Total Deaths", value: totalDeaths.toString()),
                      customRow(title: "Total Recovered", value: totalRecovered.toString()),
                      customRow(title: "Today Recovered", value: todayRecovered.toString()),
                      customRow(title: "Active", value: active.toString()),
                      customRow(title: "Critical", value: critical.toString()),
                      customRow(title: "Tests", value: test.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(image),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
