// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:covid_19_tracker/models/world_states_model.dart';
import 'package:covid_19_tracker/services/Utils/app_url.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<WorldStatesModel> fetchWorldStatesRecord() async {
    http.Response response;
    response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return WorldStatesModel.fromJson(data);
    } else {
      return throw Exception("Error");
    }
  }

  Future<List<dynamic>> countryListApi() async {
    var data;
    http.Response response;
    response = await http.get(Uri.parse(AppUrl.countryList));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
      return data;
    } else {
      return throw Exception("Error");
    }
  }
}
