import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:spinner/spinner/index.dart';

import 'explore_page_state_data.dart';
import 'profile_fetcher.dart';

const int elementsPerHalf = 7;
const int centerElementIndex = elementsPerHalf~/2;

class ProfileBloc {
  final ValueNotifier<ExplorePageStateData> explorePageNotifier = ValueNotifier<ExplorePageStateData>(ExplorePageStateData.loading());
  final ProfileFetcher _profileFetcher = ProfileFetcher();

  void fetchProfiles() async {
    explorePageNotifier.value = ExplorePageStateData.loading();
    await Future.delayed(const Duration(seconds: 2));
    ProfileResult profileResult = await _profileFetcher.getProfiles(
      currentIndex: 0,
      limit: elementsPerHalf,
    );
    if (profileResult.profiles.length < elementsPerHalf) {
      explorePageNotifier.value = ExplorePageStateData.loadedLimited(profileResult.profiles);
    } else {
      explorePageNotifier.value = ExplorePageStateData.loadedWheel(
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
