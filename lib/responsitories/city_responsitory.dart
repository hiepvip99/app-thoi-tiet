import 'package:dio/dio.dart';
import 'package:weather_app/models/city.dart';

class CityResponsitory {
  Future<List<City>> getLatLong(String name) async {
    String url =
        'https://api.openweathermap.org/geo/1.0/direct?q=$name&limit=1&lang=vi&appid=666f69aafa7c68c6a17ea2db11f90dd5';
    final response = await Dio().get(url);
    final listCity = response.data as List;
    if (response.statusCode == 200) {
      return listCity.map((e) => City.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load city");
    }
  }
}
