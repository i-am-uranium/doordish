// ignore_for_file: argument_type_not_assignable

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/location.dart';
import '../utils/logger.dart';

const _url = 'https://geolocation-db.com/json/';

class LocationAPI {
  LocationAPI();
  Future<String> fetchData() async {
    String _city = '';
    final resp = await http.get(_url);
    if (resp.statusCode == 200) {
      logger.i('resp.body is ${resp.body}');
      final _data = LocationModel.fromJson(json.decode(resp.body));

      _city = _data.city;
    }

    return _city;
  }
}
