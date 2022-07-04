import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable{
  const WeatherEvent();
}

class WeatherEventRequested extends WeatherEvent{
  final String city;
  const WeatherEventRequested({required this.city});

  @override
  // TODO: implement props
  List<Object?> get props => [city];
}

class WeatherEventRefreshed extends WeatherEvent{
  final String city;
  const WeatherEventRefreshed({required this.city});

  @override
  // TODO: implement props
  List<Object?> get props => [city];
}