// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/city_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/models/city.dart';
import 'package:weather_app/responsitories/city_responsitory.dart';
import 'package:weather_app/responsitories/weather_responsitory.dart';
import 'package:weather_app/screen/detail/my_detail_page.dart';
import 'package:weather_app/setting/theme.dart';

TextEditingController seachController = TextEditingController();

class MySaveCityPage extends StatefulWidget {
  const MySaveCityPage({super.key});

  @override
  State<MySaveCityPage> createState() => _MySaveCityPageState();
}

class _MySaveCityPageState extends State<MySaveCityPage> {
  bool isChange = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return BlocProvider(
                          create: (context) => CityBloc(CityResponsitory()),
                          child: BlocBuilder<CityBloc, CityState>(
                            builder: (context, state) {
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                color: Colors.amber,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextFormField(
                                        controller: seachController,
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            context.read<CityBloc>().add(
                                                LoadCityEvent(cityName: value));
                                          }
                                        },
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            hintText:
                                                'Nhập tên thành phố mà bạn muốn tìm'),
                                      ),
                                      (state is LoadingCity)
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : (state is LoadedCity)
                                              ? ListView.builder(
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) => Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Flexible(
                                                        flex: 4,
                                                        child: FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Text(
                                                              '${state.cities[index].name}  lat: ${state.cities[index].lat}  lon: ${state.cities[index].lon}'),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            City city = state
                                                                .cities[index];
                                                            context
                                                                .read<
                                                                    CityBloc>()
                                                                .add(SavedCityEvent(
                                                                    city:
                                                                        city));
                                                            Navigator.pop(
                                                                context);
                                                            context
                                                                .read<
                                                                    CityBloc>()
                                                                .add(
                                                                    LoadCityLocalEvent());
                                                            setState(() {
                                                              isChange = true;
                                                            });
                                                          },
                                                          icon: const Icon(
                                                              Icons.add),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  itemCount:
                                                      state.cities.length,
                                                )
                                              : Container(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Test')),
              const SearchAndEdit(),
              BlocProvider(
                create: (context) =>
                    CityBloc(CityResponsitory())..add(LoadCityLocalEvent()),
                child: BlocBuilder<CityBloc, CityState>(
                  builder: (context, state) {
                    if (isChange) {
                      context.read<CityBloc>().add(LoadCityLocalEvent());
                      isChange = !isChange;
                    }
                    if (state is LoadingCityLocal) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LoadedCityLocal) {
                      return Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: state.citylocals
                              .map((e) => ItemCity(
                                    city: e,
                                  ))
                              .toList());
                    } else if (state is ErrorLoadCityLocal) {
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemCity extends StatelessWidget {
  ItemCity({Key? key, required this.city}) : super(key: key);

  City city;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(WeatherResponsitory())
        ..add(LoadCityWeatherEvent(city: city)),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is LoadingWeather) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedWeather) {
            return Card(
              elevation: 500,
              color: LightTheme.backgroundColorItem,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Text(
                            //   '${state.weather.main!.temp} *',
                            //   style: const TextStyle(
                            //       fontSize: 48,
                            //       color: LightTheme.foregroundColor),
                            // ),
                            ShowTemp(
                                temp: state.weather.main!.temp,
                                fontSize: 48,
                                color: LightTheme.foregroundColor),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${state.weather.name}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: LightTheme.foregroundColor),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${state.weather.sys!.country}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: LightTheme.foregroundColor),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.sunny, size: 64),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.water_drop_outlined,
                              color: LightTheme.icon3Color,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${state.weather.main!.humidity} %',
                              style: const TextStyle(
                                  color: LightTheme.foregroundColor,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
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
                              '${state.weather.wind!.speed} km/h',
                              style: const TextStyle(
                                  color: LightTheme.foregroundColor,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else if (state is ErrorLoadWeather) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class SearchAndEdit extends StatelessWidget {
  const SearchAndEdit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Flexible(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
        ),
        Flexible(
          flex: 8,
          child: TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: LightTheme.textSearchColor),
              hintText: 'Search',
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
          ),
        ),
      ],
    );
  }
}
