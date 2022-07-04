// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/events/settings_event.dart';
import 'package:flutter_weather_app/states/settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(const SettingsState(temperatureUnit: TemperatureUnit.celsius));

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent settingsEvent) async* {
    if (settingsEvent is SettingsEventToggleUnit) {
      final newSettingState = SettingsState(
          temperatureUnit: state.temperatureUnit == TemperatureUnit.celsius
              ? TemperatureUnit.fahrenheit
              : TemperatureUnit.celsius);
      yield newSettingState;
    }
  }
}
