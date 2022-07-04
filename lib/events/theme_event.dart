import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable{
  const ThemeEvent();
}

class ThemeEventChanged extends ThemeEvent{
  final String weatherConditional;
  const ThemeEventChanged({required this.weatherConditional});
  @override
  // TODO: implement props
  List<Object?> get props => [weatherConditional];
}