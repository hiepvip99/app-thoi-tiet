// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/models/weather_datail.dart';
import 'package:weather_app/models/weather_of_city.dart';
import 'package:weather_app/responsitories/weather_responsitory.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherResponsitory loadWeather;
  WeatherBloc(this.loadWeather) : super(LoadingWeather()) {
    on<LoadWeatherEvent>((event, emit) async {
      emit(LoadingWeather());
      if (event is LoadWeatherEvent) {
        try {
          Location location = Location();
          bool ison = await location.serviceEnabled();
          if (!ison) {
            //if defvice is off
            bool isturnedon = await location.requestService();
            if (isturnedon) {
              print("GPS device is turned ON");
            } else {
              print("GPS Device is still OFF");
            }
          }
          _position = await _determinePosition();
          final WeatherOfCity weather = await loadWeather.getWeather(
              _position!.latitude, _position!.longitude);
          final WeatherDetail detail = await loadWeather.getWeatherDetail(
              _position!.latitude, _position!.longitude);
          emit(LoadedWeather(weather, detail));
          // }
        } catch (e) {
          emit(ErrorLoadWeather(e.toString()));
        }
      }
    });

    on<LoadCityWeatherEvent>((event, emit) async {
      emit(LoadingWeather());
      if (event is LoadCityWeatherEvent) {
        try {
          final WeatherOfCity weather =
              await loadWeather.getWeather(event.city.lat, event.city.lon);
          final WeatherDetail detail = await loadWeather.getWeatherDetail(
              event.city.lat, event.city.lon);
          emit(LoadedWeather(weather, detail));
          // }
        } catch (e) {
          emit(ErrorLoadWeather(e.toString()));
        }
      }
    });
  }

  Position? _position;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
