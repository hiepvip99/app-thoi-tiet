part of 'city_bloc.dart';

@immutable
abstract class CityState {}

class LoadingCity extends CityState {}

class LoadedCity extends CityState {
  // final City city;
  LoadedCity({required this.cities});
  final List<City> cities;
}

class ErrorLoadCity extends CityState {
  final String error;
  ErrorLoadCity({required this.error});
}

// Load data from database that is city saved
class LoadingCityLocal extends CityState {}

class LoadedCityLocal extends CityState {
  final List<City> citylocals;
  LoadedCityLocal({required this.citylocals});
}

class ErrorLoadCityLocal extends CityState {
  ErrorLoadCityLocal({required this.error});
  final String error;
}
