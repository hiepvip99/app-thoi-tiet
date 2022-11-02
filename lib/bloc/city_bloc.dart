import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/responsitories/city_responsitory.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final CityResponsitory _responsitory;
  CityBloc(this._responsitory) : super(LoadingCity()) {
    on<LoadCityEvent>((event, emit) async {
      emit(LoadingCity());
      try {
        // if (event is LoadCityEvent) {
        final city = await _responsitory.getLatLong(event.cityName);
        emit(LoadedCity(cities: city));
        // }
      } catch (e) {
        emit(ErrorLoadCity(error: e.toString()));
      }
    });

    on<LoadCityLocalEvent>((event, emit) async {
      emit(LoadingCityLocal());
      CityProvider provider = CityProvider();
      try {
        // if (event is LoadCityLocalEvent) {

        await provider.open();
        final cities = await provider.getAllCity();
        // provider.close;
        emit(LoadedCityLocal(citylocals: cities));
        // }
      } catch (e) {
        emit(ErrorLoadCityLocal(error: e.toString()));
      }
      // provider.close();
    });

    on<SavedCityEvent>((event, emit) async {
      CityProvider provider = CityProvider();
      try {
        await provider.open();
        await provider.insert(event.city);
        // await provider.close();
      } catch (e) {
        throw Exception(e);
      }
      // provider.close();
    });
  }
}
