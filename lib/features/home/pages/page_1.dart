import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathermap_project/features/home/managers/home_bloc.dart';
import 'package:weathermap_project/features/home/widgets/temperature_widget.dart';
import 'package:weathermap_project/features/saved_locations/pages/page_2.dart';

import '../managers/home_event.dart';
import '../managers/home_state.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(LoadEvent("New York"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            image: state.cityImageUrl != null
                ? DecorationImage(
                    image: NetworkImage(state.cityImageUrl!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: Stack(
            children: [
              Container(color: Colors.black.withOpacity(0.4)),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35,),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.white),
                            SizedBox(width: 2),
                            Text(
                              state.weather?.city ?? "Loading...",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchPage(),
                                  ),
                                );
                              },
                              child: Icon(Icons.menu, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: state.loading ?? false
                            ? const Center(child: CircularProgressIndicator())
                            : state.error != null
                            ? Center(
                                child: Text(
                                  state.error!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              )
                            : state.weather == null
                            ? const Center(child: Text("Shahar topilmadi"))
                            : SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 100),
                                  child: TemperatureWidget(
                                    weatherModel: state.weather!,
                                  ),
                                ),
                              ),
                      ),
                      if (state.predictionModel != null)
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.predictionModel!.dailyForecasts.length,
                            itemBuilder: (context, index) {
                              final day = state.predictionModel!.dailyForecasts[index];
                              return Container(
                                width: 100,
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(day.weekDay, style: const TextStyle(color: Colors.white)),
                                    const SizedBox(height: 4),
                                    Text("${day.temp.toStringAsFixed(1)}°C", style: const TextStyle(color: Colors.white)),
                                    Image.network(
                                      "http://openweathermap.org/img/wn/${day.weatherIcon}@2x.png",
                                      width: 50,
                                      height: 50,
                                    ),
                                    Text(day.weatherMain, style: const TextStyle(color: Colors.white)),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
