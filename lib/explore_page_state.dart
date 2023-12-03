import 'package:flutter/cupertino.dart';

import 'profile_state.dart';

enum State {
  loading,
  loadedLimited,
  loadedWheel,
  error,
}

class ExplorePageState {
  final State _state;

  State get state => _state;

  final List<ValueNotifier<ProfileInfo>>? _profileStatesNotifier;

  List<ValueNotifier<ProfileInfo>> get profileStatesNotifier => _profileStatesNotifier!;

  int? _nextFetchIndex;

  int get nextFetchIndex => _nextFetchIndex!;

  final int? _elementsInWheel;

  set nextFetchIndex(int value) {
    _nextFetchIndex = value;
  }

  ExplorePageState(
    this._state,
    this._profileStatesNotifier,
    this._elementsInWheel,
  );

  ExplorePageState.loading()
      : _state = State.loading,
        _profileStatesNotifier = null,
        _elementsInWheel = null;

  ExplorePageState.loadedLimited(
    List<ProfileDTO> profiles,
  )   : _state = State.loadedLimited,
        _profileStatesNotifier = profiles.map((e) => ValueNotifier(ProfileInfo.loaded(e))).toList(),
        _elementsInWheel = null;

  ExplorePageState.loadedWheel(
    List<ProfileDTO> profiles,
    int elementsInWheel,
    this._nextFetchIndex,
  )   : _state = State.loadedWheel,
        _elementsInWheel = elementsInWheel,
        _profileStatesNotifier = List.generate(
          elementsInWheel * 2,
          (index) {
            if (index < profiles.length) {
              return ValueNotifier(ProfileInfo.loaded(profiles[index]));
            } else {
              return ValueNotifier(ProfileInfo.notVisible());
            }
          },
        );

  ExplorePageState.error()
      : _state = State.error,
        _elementsInWheel = null,
        _profileStatesNotifier = null;

  void markProfileIndicesAsInvisible(List<int> indexes) {
    for (var i in indexes) {
      _profileStatesNotifier![i].value = ProfileInfo.notVisible();
    }
  }

  void markProfileIndicesAsLoading(List<int> indexes) {
    for (var i in indexes) {
      _profileStatesNotifier![i].value = ProfileInfo.loading();
    }
  }

  void loadProfiles(
    List<ProfileDTO> profiles,
  ) {
    int i = 0;
    for (var e in _profileStatesNotifier!) {
      if (e.value.state == ProfileState.loading) {
        if (i < profiles.length) {
          e.value = ProfileInfo.loaded(profiles[i]);
          i++;
        }
      }
    }
  }

  void removeCenterProfile(int centerIndex) {
    if (_state == State.loadedLimited) {
      _profileStatesNotifier!.removeAt(centerIndex);
    } else if (_state == State.loadedWheel){
      int elementsOnRightSideOfCenter = _elementsInWheel!~/2;
      int totalElementsOnFullWheel = _elementsInWheel*2;
      for(int i=0;i<elementsOnRightSideOfCenter;i++){
        _profileStatesNotifier![(centerIndex-i)%totalElementsOnFullWheel].value = _profileStatesNotifier[(centerIndex-i-1)%totalElementsOnFullWheel].value;
      }
      _profileStatesNotifier![(centerIndex-elementsOnRightSideOfCenter)%totalElementsOnFullWheel].value = ProfileInfo.loading();
    }
  }

  int get profilesInLoadingState => _profileStatesNotifier!.where((e) => e.value.state == ProfileState.loading).length;
}
