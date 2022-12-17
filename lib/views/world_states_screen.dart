// ignore_for_file: prefer_const_constructors

import 'package:covid_19_tracker/models/world_states_model.dart';
import 'package:covid_19_tracker/services/sates_services.dart';
import 'package:covid_19_tracker/views/country_list_screen.dart';
import 'package:covid_19_tracker/widgets/custom_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  StateServices services = StateServices();

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
              FutureBuilder(
                future: services.fetchWorldStatesRecord(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        controller: _controller,
                        color: Colors.white,
                        size: 50,
                      ),
                    );
                  } else {
                    var data = snapshot.data;
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total': double.parse(data!.cases.toString()),
                            "Recovered":
                                double.parse(data.recovered.toString()),
                            "Death": double.parse(data.deaths.toString()),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: width / 2.3,
                          animationDuration: Duration(milliseconds: 1200),
                          colorList: colorList,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.02),
                          child: Card(
                            child: Column(
                              children: [
                                customRow(
                                  title: "Total",
                                  value: data.cases.toString(),
                                ),
                                customRow(
                                  title: "Deaths",
                                  value: data.deaths.toString(),
                                ),
                                customRow(
                                  title: "Recovered",
                                  value: data.recovered.toString(),
                                ),
                                customRow(
                                  title: "Active",
                                  value: data.active.toString(),
                                ),
                                customRow(
                                  title: "Critical",
                                  value: data.critical.toString(),
                                ),
                                customRow(
                                  title: "Today Cases",
                                  value: data.todayCases.toString(),
                                ),
                                customRow(
                                  title: "Today Deaths",
                                  value: data.todayDeaths.toString(),
                                ),
                                customRow(
                                  title: "Today Recovered",
                                  value: data.todayRecovered.toString(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CountryListScreen(),
                            ),
                          ),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xFF1aa260),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(child: Text("Track Contries")),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
