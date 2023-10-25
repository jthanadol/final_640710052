import 'dart:convert';

import 'package:final_640710052/weather_item.dart';

import 'api_caller.dart';

class WeatherRepository{

  Future<WeatherItem> getWeather(String city) async {
    String endPoint = 'current?city=' + city;

    try {
      var result = await ApiCaller().get(endPoint);
      Map<String , dynamic> item = jsonDecode(result);
      WeatherItem weatherItem = WeatherItem.fromJson(item);
      return weatherItem;
    } catch (e) {
      // TODO:
      rethrow;
    }
  }
}