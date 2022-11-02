import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/city_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/responsitories/city_responsitory.dart';
import 'package:weather_app/responsitories/weather_responsitory.dart';
import 'package:weather_app/screen/detail/my_detail_page.dart';
import 'package:weather_app/screen/home/my_home_page.dart';
import 'package:weather_app/screen/save_city/my_save_city_page.dart';
import 'package:weather_app/setting/theme.dart';

import 'bloc/setting_app_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<CityBloc>(
      create: (context) => CityBloc(CityResponsitory()),
    ),
    BlocProvider<WeatherBloc>(
      create: (context) =>
          WeatherBloc(WeatherResponsitory())..add(LoadWeatherEvent()),
    ),
    BlocProvider<SettingAppBloc>(
      create: (context) => SettingAppBloc()..add(LoadSettingApp()),
    ),
  ], child: const MyApp()));
}

// late SettingAppBloc settingBloc;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: LightTheme.backgroundColor,
        body: _selectedIndex == 0
            ? const MyHomePage()
            : _selectedIndex == 1
                ? const MySaveCityPage()
                : const MyDetailPage(),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: LightTheme.backgroundColor,
          items: const [
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.favorite_border),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.menu),
            ),
          ],
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          currentIndex: _selectedIndex,
          selectedItemColor: LightTheme.selectedColorBottomNAV,
          unselectedItemColor: LightTheme.unselectedColorBottomNAV,
        ),
      ),
    );
  }
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}
