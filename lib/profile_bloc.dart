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
    ProfileResult profileResult = await _profileFetcher.getProfiles(
      currentIndex: 0,
      limit: elementsPerHalf,
    );
    if (profileResult.profiles.length < elementsPerHalf) {
      explorePageNotifier.value = ExplorePageStateData.loadedLimited(
        profiles: profileResult.profiles,
        carouselController: CarouselController(),
      );
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

  void fetchNextProfiles() async {
    ProfileResult profileResult = await _profileFetcher.getProfiles(
      currentIndex: explorePageNotifier.value.nextFetchIndex,
      limit: explorePageNotifier.value.profilesInLoadingState,
    );
    if (_hasProfilesExhausted(profileResult)) {
      explorePageNotifier.value = ExplorePageStateData.loadedLimited(
        profiles: profileResult.profiles,
        carouselController: CarouselController(),
      );
    } else {
      int updatedProfiles = explorePageNotifier.value.loadProfiles(profileResult.profiles);
      if (_allLoadingProfilesWereUpdated(updatedProfiles)) {
        explorePageNotifier.value.nextFetchIndex = profileResult.nextIndex;
      } else if (_resultLessThanQueried()) {
        //Probably we reached the end..Hence fetching from the beginning
        explorePageNotifier.value.nextFetchIndex = 0;
        fetchNextProfiles();
      }
    }
  }

  bool _resultLessThanQueried() => explorePageNotifier.value.profilesInLoadingState > 0;

  bool _allLoadingProfilesWereUpdated(int updatedProfiles) => (explorePageNotifier.value.profilesInLoadingState == 0) && updatedProfiles > 0;

  bool _hasProfilesExhausted(ProfileResult profileResult) {
    return explorePageNotifier.value.nextFetchIndex == 0 && profileResult.profiles.length < explorePageNotifier.value.profilesInLoadingState;
  }

  int carouselToWheelIndex(int index) {
    return _maxIndex - index;
  }

  int get totalElementsInWheel => (elementsPerHalf * 2);

  int get _maxIndex => (totalElementsInWheel - 1);

  int wheelToCarouselIndex(int index) {
    return _maxIndex - index;
  }
}
