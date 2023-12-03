import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:profile_fetch/app_colors.dart';
import 'package:profile_fetch/carousel_profile_view.dart';
import 'package:profile_fetch/profile_bloc.dart';

import 'explore_page_state_data.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final ProfileBloc _profileBloc = ProfileBloc();

  @override
  void initState() {
    super.initState();
    _profileBloc.fetchProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ExplorePageStateData>(
      valueListenable: _profileBloc.explorePageNotifier,
      builder: (context, value, child) {
        if (value.status == Status.loading) {
          return _fullScreenLoader();
        } else if (value.status == Status.loadedWheel) {
          double viewPortFraction = 0.75;
          double cardWidth = MediaQuery.of(context).size.width * viewPortFraction;
          double aspectRatio = 0.75;
          double cardHeight = cardWidth / aspectRatio;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    height: cardHeight,
                    enlargeCenterPage: false,
                    clipBehavior: Clip.none,
                    viewportFraction: viewPortFraction,
                    initialPage: _profileBloc.wheelToCarouselIndex(centerElementIndex),
                  ),
                  itemCount: _profileBloc.totalElementsInWheel,
                  itemBuilder: (context, index, realIndex, offset) {
                    int wheelIndex = _profileBloc.carouselToWheelIndex(index);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _transformedChild(
                        offset,
                        CarouselProfileView(
                          carouselIndex: index,
                          wheelIndex: wheelIndex,
                          state: value.profileStatesNotifier[wheelIndex],
                          showIndex: true,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _fullScreenLoader() {
    return const Center(
      child: SizedBox(
        height: 50,
        width: 50,
        child: CircularProgressIndicator(
          color: AppColors.grey400,
        ),
      ),
    );
  }

  Transform _transformedChild(
    double offset,
    Widget child,
  ) {
    return Transform.rotate(
      alignment: offset > 0 ? Alignment.bottomRight : Alignment.bottomLeft,
      angle: -1 * degreesToRadians(5) * offset,
      child: child,
    );
  }

  double degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }
}
