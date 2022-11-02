// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/bloc/setting_app_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/weather_datail.dart';
import 'package:weather_app/responsitories/weather_responsitory.dart';
import 'package:weather_app/screen/home/my_home_page.dart';
import 'package:weather_app/setting/theme.dart';

class MyDetailPage extends StatefulWidget {
  const MyDetailPage({super.key});

  @override
  State<MyDetailPage> createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WeatherBloc(WeatherResponsitory())..add(LoadWeatherEvent()),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is LoadingWeather) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedWeather) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.my_location,
                          color: LightTheme.textSearchColor,
                          size: 14,
                        ),
                        Text(
                          ' Your Location Now',
                          style: TextStyle(
                              fontSize: 14, color: LightTheme.textSearchColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${state.weather.name}, ${state.weather.sys!.country}',
                      style: const TextStyle(
                          fontSize: 16, color: LightTheme.foregroundColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Icon(
                      Icons.sunny,
                      size: 200,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(246, 246, 231, 1),
                      ),
                      child: const Text(
                        'Shine',
                        style: TextStyle(
                            fontSize: 16, color: LightTheme.foregroundColor),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ShowTemp(
                        temp: double.parse(state.weather.main!.temp.toString()),
                        fontSize: 64,
                        color: LightTheme.foregroundColor),
                    const SizedBox(
                      height: 10,
                    ),
                    HumilityWindSpeed(
                        humility: state.weather.main!.humidity.toString(),
                        pressure: state.weather.main!.pressure.toString(),
                        wind_speed: state.weather.wind!.speed.toString()),
                    const SizedBox(
                      height: 20,
                    ),
                    const SettingApp(),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: const Text(
                        'Source',
                        style: TextStyle(color: LightTheme.foregroundColor),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'open weather map',
                            style: TextStyle(color: LightTheme.textSearchColor),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: LightTheme.foregroundColor,
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ErrorLoadWeather) {
            Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class ShowTemp extends StatelessWidget {
  ShowTemp(
      {Key? key,
      required this.temp,
      required this.fontSize,
      required this.color})
      : super(key: key);

  double temp;
  double fontSize;
  Color color;

  String tempSetting(double tempValue, BuildContext mcontext) {
    if (mcontext.watch<SettingAppBloc>().state.tempType == 'Celsius') {
      return '${tempValue.toStringAsFixed(2)}';
    } else if (mcontext.watch<SettingAppBloc>().state.tempType ==
        'Fahrenheit') {
      return '${(tempValue * 1.8 + 32).toStringAsFixed(2)}';
    } else {
      return '${(tempValue + 273.15).toStringAsFixed(2)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) => settingBloc,
    // child: BlocBuilder<SettingAppBloc, SettingAppState>(
    return BlocBuilder<SettingAppBloc, SettingAppState>(
      builder: (context, state) {
        return Text(
          '${tempSetting(temp, context)} °',
          style: TextStyle(color: color, fontSize: fontSize),
        );
      },
      // ),
    );
  }
}

class SettingApp extends StatefulWidget {
  const SettingApp({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingApp> createState() => _SettingAppState();
}

class _SettingAppState extends State<SettingApp> {
  List<String> typeTemps = ['Celsius', 'Fahrenheit', 'Kelvin'];

  // String tempValue = 'Celsius';

  Future<void> _showMyDialog(
      SettingAppState state, BuildContext mcontext) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Temperature Type'),
          content: SingleChildScrollView(
            child: Column(
              children: typeTemps
                  .map(
                    (e) => RadioListTile<String>(
                      value: e,
                      selected: state.tempType == e ? true : false,
                      title: Text(e),
                      groupValue: state.tempType,
                      onChanged: (value) {
                        setState(() {
                          // tempValue = value.toString();
                          mcontext.read<SettingAppBloc>().add(ChangeSettingApp(
                              changeTempType: value!,
                              changeWindSpeedType: state.windSpeedType));
                          Navigator.pop(context);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  List<String> speedTypes = ['Km/h', 'M/s'];

  // String speedValue = 'M/s';

  Future<void> _showMyDialogSpeed(
      SettingAppState state, BuildContext mcontext) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Speed Type'),
          content: SingleChildScrollView(
            child: Column(
              children: speedTypes
                  .map(
                    (e) => RadioListTile<String>(
                      value: e,
                      selected: state.windSpeedType == e ? true : false,
                      title: Text(e),
                      groupValue: state.windSpeedType,
                      onChanged: (value) {
                        setState(() {
                          // speedValue = value.toString();
                          mcontext.read<SettingAppBloc>().add(ChangeSettingApp(
                              changeTempType: state.tempType,
                              changeWindSpeedType: value!));
                          Navigator.pop(context);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) => settingBloc..add(LoadSettingApp()),
    // child: BlocBuilder<SettingAppBloc, SettingAppState>(
    return BlocBuilder<SettingAppBloc, SettingAppState>(
      builder: (context, state) {
        if (state is SettingAppLoaded) {
          return Column(
            children: [
              ListTile(
                title: const Text(
                  'Temperature',
                  style: TextStyle(color: LightTheme.foregroundColor),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${state.tempType}',
                      style: const TextStyle(color: LightTheme.textSearchColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: LightTheme.foregroundColor,
                    )
                  ],
                ),
                onTap: () {
                  _showMyDialog(state, context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text(
                  'Wind Speed',
                  style: TextStyle(color: LightTheme.foregroundColor),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${state.windSpeedType}',
                      style: const TextStyle(color: LightTheme.textSearchColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: LightTheme.foregroundColor,
                    )
                  ],
                ),
                onTap: () {
                  _showMyDialogSpeed(state, context);
                },
              ),
            ],
          );
        } else if (state is SettingAppInitial) {
          return Column(
            children: [
              ListTile(
                title: const Text(
                  'Temperature',
                  style: TextStyle(color: LightTheme.foregroundColor),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${state.tempType}',
                      style: const TextStyle(color: LightTheme.textSearchColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: LightTheme.foregroundColor,
                    )
                  ],
                ),
                onTap: () {
                  _showMyDialog(state, context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text(
                  'Wind Speed',
                  style: TextStyle(color: LightTheme.foregroundColor),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${state.windSpeedType}',
                      style: const TextStyle(color: LightTheme.textSearchColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: LightTheme.foregroundColor,
                    )
                  ],
                ),
                onTap: () {
                  _showMyDialogSpeed(state, context);
                },
              ),
            ],
          );
        }
        return Container();
      },
      // ),
    );
  }
}
