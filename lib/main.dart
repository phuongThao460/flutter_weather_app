// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/blocs/settings_bloc.dart';
import 'package:flutter_weather_app/blocs/theme_bloc.dart';
import 'package:flutter_weather_app/blocs/weather_bloc.dart';
import 'package:flutter_weather_app/blocs/weather_bloc_observer.dart';
import 'package:flutter_weather_app/blocs/weather_icon_bloc.dart';
import 'package:flutter_weather_app/repository/weather_repo.dart';
import 'package:flutter_weather_app/screens/weather_screen.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = WeatherBlocObserver();
  final WeatherRepository weatherRepository =
      WeatherRepository(httpClient: http.Client());
  //other bloc ???
  runApp(MultiBlocProvider(providers: [
    BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
    BlocProvider<SettingsBloc>(create: (context) => SettingsBloc()),
    BlocProvider<WeatherIconBloc>(create: (context) => WeatherIconBloc(weatherRepository: weatherRepository))
  ], child: MyApp(
    weatherRepository: weatherRepository,
  )));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  MyApp({Key? key, required this.weatherRepository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => WeatherBloc(weatherRepository: weatherRepository),
        child: const WeatherScreen(),
      ),
    );
  }
}
