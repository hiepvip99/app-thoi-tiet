part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class LoadWeatherEvent extends WeatherEvent {}

class LoadCityWeatherEvent extends WeatherEvent {
  final City city;
  LoadCityWeatherEvent({required this.city});
}
