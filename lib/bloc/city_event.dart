part of 'city_bloc.dart';

@immutable
abstract class CityEvent {}

class LoadCityEvent extends CityEvent {
  final String cityName;
  LoadCityEvent({required this.cityName});
}

class LoadCityLocalEvent extends CityEvent {}

class SavedCityEvent extends CityEvent {
  final City city;
  SavedCityEvent({required this.city});
}
