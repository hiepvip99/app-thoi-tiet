// ignore_for_file: must_be_immutable, non_constant_identifier_names, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/models/weather_datail.dart';
import 'package:weather_app/screen/detail/my_detail_page.dart';
import 'package:weather_app/setting/theme.dart';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) =>
    //       WeatherBloc(WeatherResponsitory())..add(LoadWeatherEvent()),
    // child: BlocBuilder<WeatherBloc, WeatherState>(
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is LoadingWeather) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedWeather) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  HeaderHomePage(
                      name: state.weather.name!,
                      temp: state.weather.main!.temp.toString(),
                      weather_des: state.weather.weather!.first.main!),
                  HumilityWindSpeed(
                      humility: state.weather.main!.humidity.toString(),
                      pressure: state.weather.main!.pressure.toString(),
                      wind_speed: state.weather.wind!.speed.toString()),
                  const Divider(),
                  Today(listHourly: state.detail.hourly!),
                  NextDay(daily: state.detail.daily!),
                ],
              ),
            ),
          );
        } else if (state is ErrorLoadWeather) {
          return Center(
            child: Text('${state.error}   Error'),
          );
        }
        return Container();
      },
      // ),
    );
  }
}

class NextDay extends StatelessWidget {
  NextDay({Key? key, required this.daily}) : super(key: key);

  List<Daily> daily;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemBuilder: (context, index) => ItemNextDay(daily: daily[index]),
        itemCount: daily.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }
}

class ItemNextDay extends StatelessWidget {
  ItemNextDay({super.key, required this.daily});

  Daily daily;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            // Cộng giờ gmt +7
            DateFormat.EEEE().format(DateTime.fromMillisecondsSinceEpoch(
                daily.dt! * 1000 + 7 * 60 * 60 * 1000)),
            style: const TextStyle(
                color: LightTheme.foregroundColor, fontSize: 16),
          ),
          const Icon(Icons.sunny),
          Row(
            children: [
              ShowTemp(
                  temp: daily.temp!.max,
                  fontSize: 18,
                  color: LightTheme.foregroundColor),
              // Text(
              //   ShowTemp(temp: )+
              //   ' °',
              //   style: const TextStyle(
              //       color: LightTheme.foregroundColor, fontSize: 18),
              // ),
              const SizedBox(
                width: 10,
              ),
              // Text(
              //   '${daily.temp!.min} °',
              //   style: const TextStyle(
              //       color: LightTheme.textSearchColor, fontSize: 18),
              // ),
              ShowTemp(
                  temp: daily.temp!.min,
                  fontSize: 18,
                  color: LightTheme.textSearchColor),
            ],
          )
        ],
      ),
    );
  }
}

class Today extends StatelessWidget {
  Today({Key? key, required this.listHourly}) : super(key: key);

  List<Hourly> listHourly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Today',
            style: TextStyle(color: LightTheme.todayColor, fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            itemBuilder: (context, index) =>
                ItemTempHourToDay(hourly: listHourly[index]),
            itemCount: listHourly.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}

class ItemTempHourToDay extends StatelessWidget {
  ItemTempHourToDay({Key? key, required this.hourly}) : super(key: key);

  Hourly hourly;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            DateFormat.j().format(
              // Cộng giờ gmt +7
              DateTime.fromMillisecondsSinceEpoch(
                hourly.dt! * 1000 + 7 * 60 * 60 * 1000,
              ),
            ),
            style: const TextStyle(
                color: LightTheme.foregroundColor, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          const Icon(Icons.sunny),
          const SizedBox(
            height: 10,
          ),
          ShowTemp(
              temp: double.parse(hourly.temp.toString()),
              fontSize: 20,
              color: LightTheme.foregroundColor),
          // Text(
          //   '${hourly.temp} °',
          //   style: const TextStyle(
          //       color: LightTheme.foregroundColor, fontSize: 20),
          // )
        ],
      ),
    );
  }
}

class HumilityWindSpeed extends StatelessWidget {
  HumilityWindSpeed({
    Key? key,
    required this.humility,
    required this.pressure,
    required this.wind_speed,
  }) : super(key: key);

  String humility;
  String pressure;
  String wind_speed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.water_drop_outlined,
                color: LightTheme.icon3Color,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '$humility%',
                style: const TextStyle(color: LightTheme.foregroundColor),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.arrow_circle_down,
                color: LightTheme.icon3Color,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '$pressure mBar',
                style: const TextStyle(color: LightTheme.foregroundColor),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.air,
                color: LightTheme.icon3Color,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '$wind_speed km/h',
                style: const TextStyle(color: LightTheme.foregroundColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HeaderHomePage extends StatelessWidget {
  HeaderHomePage({
    Key? key,
    required this.name,
    required this.temp,
    required this.weather_des,
  }) : super(key: key);

  String name;
  String temp;
  String weather_des;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              'assets/images/image1.png',
              height: 200,
              width: 200,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '$name',
                        style: const TextStyle(
                            color: LightTheme.foregroundColor, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //   '$temp °',
                      //   style: const TextStyle(
                      //       color: LightTheme.foregroundColor, fontSize: 64),
                      // ),
                      ShowTemp(
                          temp: double.parse(temp),
                          fontSize: 64,
                          color: LightTheme.foregroundColor),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(242, 239, 236, 1),
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        // color: Color.fromRGBO(242, 239, 236, 1),
                        child: Text(
                          '$weather_des',
                          style: const TextStyle(
                              color: LightTheme.foregroundColor, fontSize: 16),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
