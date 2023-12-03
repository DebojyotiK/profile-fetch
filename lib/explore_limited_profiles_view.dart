import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'carousel_profile_view.dart';
import 'explore_page_state_data.dart';
import 'profile_bloc.dart';

class ExploreLimitedProfilesView extends StatelessWidget {
  final bool showIndex;
  final ProfileBloc profileBloc;

  const ExploreLimitedProfilesView({
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _carouselView(cardHeight, viewPortFraction, stateData),
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
        onPageChanged: (index, reason) {
          //TODO: Change carousel
        },
        enableInfiniteScroll: false,
      ),
      itemCount: value.profileStatesNotifier.length,
      itemBuilder: (context, index, realIndex, offset) {
        return CarouselProfileView(
          carouselIndex: index,
          wheelIndex: index,
          state: value.profileStatesNotifier[index],
          showIndex: showIndex,
          offset: offset,
          onSendRequest: () {
            value.removeCenterProfile(index);
          },
        );
      },
      carouselController: value.carouselController,
    );
  }
}
