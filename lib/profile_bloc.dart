import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:spinner/spinner/index.dart';

import 'explore_page_state.dart';
import 'profile_fetcher.dart';

const int elementsPerHalf = 7;

class ProfileBloc {
  final ValueNotifier<ExplorePageState> explorePageNotifier = ValueNotifier<ExplorePageState>(ExplorePageState.loading());
  final ProfileFetcher _profileFetcher = ProfileFetcher();

  void fetchProfiles() async {
    explorePageNotifier.value = ExplorePageState.loading();
    ProfileResult profileResult = await _profileFetcher.getProfiles(
      currentIndex: 0,
      limit: elementsPerHalf,
    );
    if (profileResult.profiles.length < elementsPerHalf) {
      explorePageNotifier.value = ExplorePageState.loadedLimited(profileResult.profiles);
    } else {
      explorePageNotifier.value = ExplorePageState.loadedWheel(
        profiles: profileResult.profiles,
        elementsInWheel: elementsPerHalf,
        nextFetchIndex: profileResult.nextIndex,
        carouselController: CarouselController(),
        spinnerController: SpinnerController(elementsPerHalf),
      );
    }
  }

  int carouselToWheelIndex(int index) {
    return totalElementsInWheel - index;
  }

  int get totalElementsInWheel => (elementsPerHalf * 2 - 1);

  int wheelToCarouselIndex(int index) {
    return totalElementsInWheel - index;
  }
}
