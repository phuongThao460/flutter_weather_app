// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather.dart';

class WeatherDescription extends StatelessWidget {
  final List<WeatherDetail> weatherDetail;

  const WeatherDescription({Key? key, required this.weatherDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: weatherDetail.length,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(children: [
              Image.network('http://openweathermap.org/img/wn/${weatherDetail[index].icon}@2x.png'),
              Text(weatherDetail[index].main!, style: const TextStyle(fontSize: 20),),
              Text(weatherDetail[index].description!, style: const TextStyle(fontSize: 20),)
            ]);
          }),
    );
  }
}
