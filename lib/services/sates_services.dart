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
}
