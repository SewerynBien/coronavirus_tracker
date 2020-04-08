import 'dart:convert';

import 'package:coronavirus_tracker/managers/handle_errors_manager.dart';
import 'package:coronavirus_tracker/models/country.dart';
import 'package:http/http.dart' as http;

class NetworkManager {
  final String URL = 'https://corona.lmao.ninja/countries';

  Future<List<Country>> fetchCountries() async {
    try {
      var response = await http.get(URL);
      if (response.statusCode == 200)
        return parseCountries(response.body);
      else
        return null;
    } on Exception {
      return null;
    }
  }

  List<Country> parseCountries(String responseBody) {
    List<Country> countries = new List();
    for (var responseElement in json.decode(responseBody))
      countries.add(parseCountry(responseElement));
    return countries;
  }

  Country parseCountry(var json) {
    HandleErrorsManager handleErrorsManager = new HandleErrorsManager();

    return new Country(
      name: handleErrorsManager.catchNullInStringValue(json['country']),
      latitude: handleErrorsManager
          .catchNullInDoubleValue(json['countryInfo']['lat']),
      longitude: handleErrorsManager
          .catchNullInDoubleValue(json['countryInfo']['long']),
      casesPerOneMillion: handleErrorsManager
          .catchNullInDoubleValue(json['casesPerOneMillion']),
      deathsPerOneMillion: handleErrorsManager
          .catchNullInDoubleValue(json['deathsPerOneMillion']),
      cases: handleErrorsManager.catchNullInIntValue(json['cases']),
      todayCases: handleErrorsManager.catchNullInIntValue(json['todayCases']),
      deaths: handleErrorsManager.catchNullInIntValue(json['deaths']),
      todayDeaths: handleErrorsManager.catchNullInIntValue(json['todayDeaths']),
      recovered: handleErrorsManager.catchNullInIntValue(json['recovered']),
      active: handleErrorsManager.catchNullInIntValue(json['active']),
      critical: handleErrorsManager.catchNullInIntValue(json['critical']),
    );
  }
}
