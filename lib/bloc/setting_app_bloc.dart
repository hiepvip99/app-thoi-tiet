// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'setting_app_event.dart';
part 'setting_app_state.dart';

class SettingAppBloc extends Bloc<SettingAppEvent, SettingAppState> {
  SettingAppBloc() : super(SettingAppInitial()) {
    on<SettingAppEvent>((event, emit) async {
      if (event is LoadSettingApp) {
        try {
          final prefs = await SharedPreferences.getInstance();
          String tempType = (prefs.getString('tempType') ?? 'Celsius');
          String windSpeedType = (prefs.getString('windSpeedType') ?? 'Km/h');
          emit(SettingAppLoaded(tempType, windSpeedType));
        } catch (e) {
          print(e);
        }
      }
      if (event is ChangeSettingApp) {
        try {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('tempType', event.changeTempType);
          prefs.setString('windSpeedType', event.changeWindSpeedType);
          emit(SettingAppLoaded(
              event.changeTempType, event.changeWindSpeedType));
        } catch (e) {
          print(e);
        }
      }
    });
  }
}
