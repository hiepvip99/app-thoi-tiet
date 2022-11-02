part of 'setting_app_bloc.dart';

@immutable
abstract class SettingAppEvent {}

class LoadSettingApp extends SettingAppEvent {}

class ChangeSettingApp extends SettingAppEvent {
  final String changeTempType;
  final String changeWindSpeedType;
  ChangeSettingApp(
      {required this.changeTempType, required this.changeWindSpeedType});
}
