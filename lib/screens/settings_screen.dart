import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/blocs/settings_bloc.dart';
import 'package:flutter_weather_app/events/settings_event.dart';
import 'package:flutter_weather_app/states/settings_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setting'),),
      body: ListView(children: [
        BlocBuilder<SettingsBloc, SettingsState>(builder: (context, settingsState){
          return ListTile(
            title: const Text('Temperature Unit'),
            isThreeLine: true,
            subtitle: Text(settingsState.temperatureUnit == TemperatureUnit.celsius ? 'Celsius' : 'Fahrenheit'),
            trailing: Switch(
              value: settingsState.temperatureUnit == TemperatureUnit.celsius,
              onChanged: (_) => BlocProvider.of<SettingsBloc>(context).add(SettingsEventToggleUnit()),
            ),
          );
        })
      ],),
    );
  }
}
