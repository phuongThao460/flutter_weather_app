// ignore_for_file: avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/events/theme_event.dart';
import 'package:flutter_weather_app/states/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc():super(const ThemeState(backgroundColor: Colors.lightBlueAccent, textColor: Colors.black));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent themeEvent) async* {
    late ThemeState newThemeState;
    if(themeEvent is ThemeEventChanged){
      final weatherCondition = themeEvent.weatherConditional;
      if(weatherCondition == 'Clouds'){
        newThemeState = const ThemeState(backgroundColor: Colors.grey, textColor: Colors.black);
      } else if(weatherCondition == 'Rain'){
        newThemeState = const ThemeState(backgroundColor: Colors.lightBlue, textColor: Colors.white);
      } else if(weatherCondition == 'Thunderstorm'){
        newThemeState = const ThemeState(backgroundColor: Colors.grey, textColor: Colors.white);
      } else if(weatherCondition == 'Snow'){
        newThemeState = const ThemeState(backgroundColor: Colors.white, textColor: Colors.black);
      } else if(weatherCondition == 'Atmosphere'){
        newThemeState = const ThemeState(backgroundColor: Colors.white24, textColor: Colors.black);
      } else if(weatherCondition == 'Clear'){
        newThemeState = const ThemeState(backgroundColor: Colors.white30, textColor: Colors.black);
      } else if(weatherCondition == 'Drizzle'){
        newThemeState = const ThemeState(backgroundColor: Colors.lightBlue, textColor: Colors.white);
      }
      yield newThemeState;
    }
  }
}