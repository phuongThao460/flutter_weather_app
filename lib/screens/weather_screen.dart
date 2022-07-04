import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/blocs/theme_bloc.dart';
import 'package:flutter_weather_app/blocs/weather_bloc.dart';
import 'package:flutter_weather_app/events/theme_event.dart';
import 'package:flutter_weather_app/events/weather_event.dart';
import 'package:flutter_weather_app/screens/city_search_screen.dart';
import 'package:flutter_weather_app/screens/settings_screen.dart';
import 'package:flutter_weather_app/screens/temperature_screen.dart';
import 'package:flutter_weather_app/screens/weather_description.dart';
import 'package:flutter_weather_app/states/theme_state.dart';
import 'package:flutter_weather_app/states/weather_state.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Completer<void>? completer;
  @override
  void initState() {
    super.initState();
    completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather app using Flutter Bloc'),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
          }, icon: const Icon(Icons.settings)),
          IconButton(onPressed: () async {
            final typeCity = await Navigator.push(context, MaterialPageRoute(builder: (context) => const CitySearchScreen()));
            if(typeCity != null){
              BlocProvider.of<WeatherBloc>(context).add(WeatherEventRequested(city: typeCity));
            }
            }, icon: const Icon(Icons.search))
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, weatherState) {
            if (weatherState is WeatherStateSuccess) {
              BlocProvider.of<ThemeBloc>(context).add(ThemeEventChanged(
                  weatherConditional:
                      weatherState.weather.weather!.map((e) => e.main!).toString()));
              completer?.complete();
              completer = Completer();
            }
          },
          builder: (context, weatherState) {
            if (weatherState is WeatherStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (weatherState is WeatherStateSuccess) {
              final weather = weatherState.weather;
              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return RefreshIndicator(
                      child: Container(
                        child: ListView(
                          children: [
                            Column(
                              children: [
                                Text(
                                  weather.name!,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: themeState.textColor),
                                ),
                                TemperatureScreen(main: weather.main!),
                                WeatherDescription(weatherDetail: weather.weather!)
                              ],
                            )
                          ],
                        ),
                        color: themeState.backgroundColor,
                      ),
                      onRefresh: () {
                        BlocProvider.of<WeatherBloc>(context)
                            .add(WeatherEventRefreshed(city: weather.name!));
                        //finished refresh
                        return completer!.future;
                      });
                },
              );
            }
            if(weatherState is WeatherStateFailure){
              return const Text('Something went wrong!');
            }
            return const Text('Select location first!');
          },
        ),
      ),
    );
  }
}
