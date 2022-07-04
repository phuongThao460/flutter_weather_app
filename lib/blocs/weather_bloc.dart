// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/events/weather_event.dart';
import 'package:flutter_weather_app/models/weather.dart';
import 'package:flutter_weather_app/repository/weather_repo.dart';
import 'package:flutter_weather_app/states/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository}):super(WeatherStateInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async* {
    if(weatherEvent is WeatherEventRequested){
      yield WeatherStateLoading();
      try{
        final Weather weather = await weatherRepository.getWeatherFromCity(weatherEvent.city);
        yield WeatherStateSuccess(weather: weather);
      } catch(exception){
        yield WeatherStateFailure();
      }
    }
    else if(weatherEvent is WeatherEventRefreshed){
      try{
        final Weather weather = await weatherRepository.getWeatherFromCity(weatherEvent.city);
        yield WeatherStateSuccess(weather: weather);
      } catch(exception){
        yield WeatherStateFailure();
      }
    }
  }
}