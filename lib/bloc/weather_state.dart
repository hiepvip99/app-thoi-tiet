part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class LoadingWeather extends WeatherState {}

class LoadedWeather extends WeatherState {
  final WeatherOfCity weather;
  final WeatherDetail detail;
  LoadedWeather(this.weather, this.detail);
}

class ErrorLoadWeather extends WeatherState {
  final String error;
  ErrorLoadWeather(this.error);
}
