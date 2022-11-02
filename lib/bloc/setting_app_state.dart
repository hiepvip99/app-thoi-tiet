// ignore_for_file: must_be_immutable

part of 'setting_app_bloc.dart';

@immutable
abstract class SettingAppState {
  String tempType;
  String windSpeedType;
  SettingAppState(this.tempType, this.windSpeedType);
}

class SettingAppInitial extends SettingAppState {
  SettingAppInitial() : super('Celsius', 'Km/h');
}

class SettingAppLoaded extends SettingAppState {
  SettingAppLoaded(super.tempType, super.windSpeedType);
}
