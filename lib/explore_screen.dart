import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:profile_fetch/app_colors.dart';
import 'package:profile_fetch/carousel_profile_view.dart';
import 'package:profile_fetch/profile_bloc.dart';
import 'package:profile_fetch/wheel_profile_view.dart';
import 'package:spinner/spinner/index.dart';
import 'package:spinner/spinner/typedefs.dart';

import 'explore_page_state_data.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final ProfileBloc _profileBloc = ProfileBloc();

  bool get _showIndex => true;

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
          double radius = MediaQuery.of(context).size.width * 0.8 / 2;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: _carouselView(cardHeight, viewPortFraction, value),
              ),
              Spinner(
                radius: radius,
                innerRadius: 0.5 * radius,
                elementsPerHalf: value.spinnerController.elementsPerHalf,
                showDebugViews: false,
                elementBuilder: (index) {
                  return WheelProfileView(
                    index: index,
                    state: value.profileStatesNotifier[index],
                    showIndex: _showIndex,
                  );
                },
                onEnteredViewPort: (indices, reason) {
                  debugPrint("$indices entered view port");
                  if (reason != SpinnerChangeReason.initialize) {
                    value.markProfileIndicesAsLoading(indices);
                  }
                },
                onLeftViewPort: (indices, reason) {
                  debugPrint("$indices left view port");
                  if (reason != SpinnerChangeReason.initialize) {
                    value.markProfileIndicesAsInvisible(indices);
                  }
                },
                onElementTapped: (index) {
                  debugPrint("$index was tapped");
                },
                onElementCameToCenter: (index, reason) {
                  debugPrint("$index came to center");
                  if (value.carouselController.ready && reason == SpinnerChangeReason.scrollEnd) {
                    value.carouselController.animateToPage(_profileBloc.wheelToCarouselIndex(index));
                    _profileBloc.fetchNextProfiles();
                  }
                },
                spinnerController: value.spinnerController,
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  CarouselSlider _carouselView(double cardHeight, double viewPortFraction, ExplorePageStateData value) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: cardHeight,
        enlargeCenterPage: false,
        clipBehavior: Clip.none,
        viewportFraction: viewPortFraction,
        initialPage: _profileBloc.wheelToCarouselIndex(centerElementIndex),
        onPageChanged: (index, reason) {
          value.spinnerController.bringElementAtIndexToCenter(_profileBloc.carouselToWheelIndex(index));
        },
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
              showIndex: _showIndex,
              onSendRequest: (){
                value.removeCenterProfile(wheelIndex);
                _profileBloc.fetchNextProfiles();
              },
            ),
          ),
        );
      },
      carouselController: value.carouselController,
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
