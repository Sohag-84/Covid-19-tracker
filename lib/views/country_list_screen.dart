// ignore_for_file: prefer_const_constructors

import 'package:covid_19_tracker/services/sates_services.dart';
import 'package:covid_19_tracker/views/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key}) : super(key: key);

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: "Search with country name",
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
            Expanded(
              child: FutureBuilder(
                future: StateServices().countryListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  height: 10,
                                  width: 90,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 90,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data![index]['countryInfo'];

                        String name = snapshot.data![index]['country'];

                        if (_searchController.text.isEmpty) {
                          return InkWell(
                            onTap: () {
                              var info = snapshot.data![index];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    image: info['countryInfo']['flag'],
                                    name: info['country'],
                                    totalCases: info['cases'],
                                    totalDeaths: info['deaths'],
                                    totalRecovered: info['recovered'],
                                    active: info['active'],
                                    critical: info['critical'],
                                    todayRecovered: info['todayRecovered'],
                                    test: info['tests'],
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(data['flag']),
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                ),
                              ],
                            ),
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              var info = snapshot.data![index];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    image: info['countryInfo']['flag'],
                                    name: info['country'],
                                    totalCases: info['cases'],
                                    totalDeaths: info['deaths'],
                                    totalRecovered: info['recovered'],
                                    active: info['active'],
                                    critical: info['critical'],
                                    todayRecovered: info['todayRecovered'],
                                    test: info['tests'],
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(data['flag']),
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(
                                      snapshot.data![index]['cases'].toString()),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
