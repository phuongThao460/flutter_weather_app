import 'package:equatable/equatable.dart';

abstract class WeatherIconEvent extends Equatable{
  const WeatherIconEvent();
}

class WeatherIconEventShow extends WeatherIconEvent{
  final String codeId;
  const WeatherIconEventShow({required this.codeId});
  @override
  // TODO: implement props
  List<Object?> get props => [codeId];
}