import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathermap_project/features/home/managers/home_bloc.dart';
import 'package:weathermap_project/features/home/managers/home_event.dart';
import 'package:weathermap_project/features/home/managers/home_state.dart';
import 'package:weathermap_project/features/saved_locations/pages/page_3.dart';

import '../widgets/weather_container.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF391A49),
                  Color(0xFF301D5C),
                  Color(0xFF262171),
                  Color(0xFF301D5C),
                  Color(0xFF391A49),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 70, left: 24, right: 24),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        "Saved Locations",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 32,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  Expanded(
                    child: ListView.builder(
                      itemCount: state.savedLocations.length,
                      itemBuilder: (context, index) {
                        final weather = state.savedLocations[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: WeatherContainer(weather: weather),
                        );
                      },
                    ),
                  ),

                  // const SizedBox(height: 16),

                  TextButton(
                    style: TextButton.styleFrom(
                      fixedSize: const Size(345, 59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      backgroundColor: const Color(0xFFAAA5A5).withAlpha(70),
                    ),
                    onPressed: () async {
                      final newCity = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ThirdPage(),
                        ),
                      );

                      if (newCity != null && newCity is String) {
                        context.read<HomeBloc>().add(LoadEvent(newCity));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add_box_outlined, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          "Add new",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
