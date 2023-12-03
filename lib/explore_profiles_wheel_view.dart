import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:spinner/spinner/spinner.dart';
import 'package:spinner/spinner/typedefs.dart';

import 'carousel_profile_view.dart';
import 'explore_page_state_data.dart';
import 'profile_bloc.dart';
import 'wheel_profile_view.dart';

class ExploreProfilesWheelView extends StatelessWidget {
  final bool showIndex;
  final ProfileBloc profileBloc;

  const ExploreProfilesWheelView({
    Key? key,
    required this.profileBloc,
    this.showIndex = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ExplorePageStateData stateData = profileBloc.explorePageNotifier.value;
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
          child: _carouselView(cardHeight, viewPortFraction, stateData),
        ),
        Spinner(
          radius: radius,
          innerRadius: 0.5 * radius,
          elementsPerHalf: stateData.spinnerController.elementsPerHalf,
          showDebugViews: false,
          elementBuilder: (index) {
            return WheelProfileView(
              index: index,
              state: stateData.profileStatesNotifier[index],
              showIndex: showIndex,
            );
          },
          onEnteredViewPort: (indices, reason) {
            debugPrint("$indices entered view port");
            if (reason != SpinnerChangeReason.initialize) {
              stateData.markProfileIndicesAsLoading(indices);
            }
          },
          onLeftViewPort: (indices, reason) {
            debugPrint("$indices left view port");
            if (reason != SpinnerChangeReason.initialize) {
              stateData.markProfileIndicesAsInvisible(indices);
            }
          },
          onElementTapped: (index) {
            debugPrint("$index was tapped");
          },
          onElementCameToCenter: (index, reason) {
            debugPrint("$index came to center");
            if (stateData.carouselController.ready && reason == SpinnerChangeReason.scrollEnd) {
              stateData.carouselController.animateToPage(profileBloc.wheelToCarouselIndex(index));
              profileBloc.fetchNextProfiles();
            }
          },
          spinnerController: stateData.spinnerController,
        ),
      ],
    );
  }

  CarouselSlider _carouselView(
    double cardHeight,
    double viewPortFraction,
    ExplorePageStateData value,
  ) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: cardHeight,
        enlargeCenterPage: false,
        clipBehavior: Clip.none,
        viewportFraction: viewPortFraction,
        initialPage: profileBloc.wheelToCarouselIndex(centerElementIndex),
        onPageChanged: (index, reason) {
          value.spinnerController.bringElementAtIndexToCenter(profileBloc.carouselToWheelIndex(index));
        },
      ),
      itemCount: value.profileStatesNotifier.length,
      itemBuilder: (context, index, realIndex, offset) {
        int wheelIndex = profileBloc.carouselToWheelIndex(index);
        return CarouselProfileView(
          carouselIndex: index,
          wheelIndex: wheelIndex,
          state: value.profileStatesNotifier[wheelIndex],
          showIndex: showIndex,
          offset: offset,
          onSendRequest: () {
            value.removeCenterProfile(wheelIndex);
            profileBloc.fetchNextProfiles();
          },
        );
      },
      carouselController: value.carouselController,
    );
  }
}
