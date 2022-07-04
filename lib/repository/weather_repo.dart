// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:convert';

import 'package:flutter_weather_app/models/weather.dart';
import 'package:http/http.dart' as http;

const baseURL = 'https://api.openweathermap.org/data/2.5/';
final locationUl = (city) => '${baseURL}weather?q=$city&appid=9ff26a9788a3fd635e3a1d6f45ef531d';
final weatherUrl = (locationId) => '${baseURL}weather?id=$locationId&appid=9ff26a9788a3fd635e3a1d6f45ef531d';
final weatherIcon = (iconCode) => 'http://openweathermap.org/img/wn/$iconCode@2x.png';

class WeatherRepository {
  final http.Client httpClient;
  WeatherRepository({required this.httpClient});

  Future<int> getLocationIdFromCity(String city) async {
    final response = await httpClient.get(Uri.parse(locationUl(city)));
    if(response.statusCode == 200){
      final city = jsonDecode(response.body) as Map;
      return city['id'] ?? {};
    } else {
      throw Exception('Cannot get the location Id: $city');
    }
  }
  Future<Weather> fetchWeather(int locationId) async {
    final response = await httpClient.get(Uri.parse(weatherUrl(locationId)));
    if(response.statusCode != 200){
      throw Exception('Cannot get the weather from location Id: $locationId');
    }
    final weatherJson = jsonDecode(response.body);
    return Weather.fromJson(weatherJson);
  }

  Future<Weather> getWeatherFromCity(String city) async {
    final int locationId = await getLocationIdFromCity(city);
    return fetchWeather(locationId);
  }

  Future<String> getIcon(String iconCode) async {
    final response = await httpClient.get(Uri.parse(weatherIcon(iconCode)));
    if(response.statusCode != 200){
      throw Exception('Cannot get the weather icon from Code Id: $iconCode');
    }
    return response.body;
  }
}