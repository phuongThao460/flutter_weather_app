// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/events/weather_icon_event.dart';
import 'package:flutter_weather_app/repository/weather_repo.dart';
import 'package:flutter_weather_app/states/weather_icon_state.dart';

class WeatherIconBloc extends Bloc<WeatherIconEvent, WeatherIconState> {
  final WeatherRepository weatherRepository;

  WeatherIconBloc({required this.weatherRepository})
      : super(WeatherIconInitialState());

  @override
  Stream<WeatherIconState> mapEventToState(
      WeatherIconEvent weatherIconEvent) async* {
    if (weatherIconEvent is WeatherIconEventShow) {
      try {
        final String iconString =
            await weatherRepository.getIcon(weatherIconEvent.codeId);
        yield WeatherIconGetState(codeId: iconString);
      } catch (exception) {
        yield WeatherIconFailureState();
      }
    }
  }
}
