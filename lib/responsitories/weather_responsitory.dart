import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:weather_app/models/weather_datail.dart';
import 'package:weather_app/models/weather_of_city.dart';

class WeatherResponsitory {
  // final String _url =
  //     'https://api.openweathermap.org/data/2.5/weather?lat=21&lon=105&units=metric&appid=666f69aafa7c68c6a17ea2db11f90dd5';
  // final String _urlDetail =
  //     'https://api.openweathermap.org/data/2.5/onecall?lat=21&lon=105&units=metric&appid=666f69aafa7c68c6a17ea2db11f90dd5';

  Future<WeatherOfCity> getWeather(double? lat, lon) async {
    Response response;
    String urlOk =
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=666f69aafa7c68c6a17ea2db11f90dd5';

    response = await Dio().get(urlOk);

    // final listPost = response.data as List;
    if (response.statusCode == 200) {
      return WeatherOfCity.fromJson(response.data);
    } else {
      throw Exception("Failed to load weather");
    }
  }

  Future<WeatherDetail> getWeatherDetail(lat, lon) async {
    String urlDetail =
        'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=666f69aafa7c68c6a17ea2db11f90dd5';
    final response = await Dio().get(urlDetail);
    if (response.statusCode == 200) {
      return WeatherDetail.fromJson(response.data);
    } else {
      throw Exception("Failed to load weather");
    }
  }
}
