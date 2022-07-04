import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/blocs/settings_bloc.dart';
import 'package:flutter_weather_app/blocs/theme_bloc.dart';
import 'package:flutter_weather_app/models/weather.dart';
import 'package:flutter_weather_app/states/settings_state.dart';
import 'package:flutter_weather_app/states/theme_state.dart';

class TemperatureScreen extends StatelessWidget {
  final Main main;

  const TemperatureScreen({Key? key, required this.main}) : super(key: key);

  int _toFahrenheit(double celsius) => ((celsius * 9 / 5) + 32).round();

  String formattedTemperature(double temp, TemperatureUnit temperatureUnit) =>
      temperatureUnit == TemperatureUnit.fahrenheit
          ? '${_toFahrenheit(temp)}°F'
          : '${temp.round()}°C';

  @override
  Widget build(BuildContext context) {
    ThemeState themeState = BlocProvider.of<ThemeBloc>(context).state;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          return Column(
            children: [
              Text(
                'Temp: ${formattedTemperature(main.temp!, settingsState.temperatureUnit)}',
                style: TextStyle(fontSize: 20, color: themeState.textColor),
              ),
              Text(
                'Temp Min: ${formattedTemperature(main.tempMin!, settingsState.temperatureUnit)}',
                style: TextStyle(fontSize: 20, color: themeState.textColor),
              ),
              Text(
                'Temp Max: ${formattedTemperature(main.tempMax!, settingsState.temperatureUnit)}',
                style: TextStyle(fontSize: 20, color: themeState.textColor),
              ),
            ],
          );
        },
      ),
    );
  }
}
