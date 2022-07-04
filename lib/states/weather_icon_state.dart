import 'package:equatable/equatable.dart';

abstract class WeatherIconState extends Equatable{
  const WeatherIconState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class WeatherIconInitialState extends WeatherIconState {}
class WeatherIconGetState extends WeatherIconState{
  final String codeId;
  const WeatherIconGetState({required this.codeId});
  @override
  // TODO: implement props
  List<Object?> get props => [codeId];
}
class WeatherIconFailureState extends WeatherIconState {}