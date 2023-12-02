import 'package:flutter/cupertino.dart';

import 'profile_state.dart';

enum State {
  loading,
  loaded,
  error,
}

class ExplorePageState {
  final State _state;

  State get state => _state;

  final List<ValueNotifier<ProfileInfo>>? _profileStatesNotifier;

  List<ValueNotifier<ProfileInfo>> get profileStatesNotifier => List.from(_profileStatesNotifier!);

  int? _nextFetchIndex;

  int get nextFetchIndex => _nextFetchIndex!;

  ExplorePageState(
    this._state,
    this._profileStatesNotifier,
  );

  ExplorePageState.loading()
      : _state = State.loading,
        _profileStatesNotifier = null;

  ExplorePageState.loadedLimited(
    List<ProfileDTO> profiles,
  )   : _state = State.loaded,
        _profileStatesNotifier = profiles.map((e) => ValueNotifier(ProfileInfo.loaded(e))).toList();

  ExplorePageState.loadedWheel(
    List<ProfileDTO> profiles,
    int totalElementsInWheel,
    this._nextFetchIndex,
  )   : _state = State.loaded,
        _profileStatesNotifier = List.generate(
          totalElementsInWheel,
          (index) {
            if (index < profiles.length) {
              return ValueNotifier(ProfileInfo.loaded(profiles[index]));
            } else {
              return ValueNotifier(ProfileInfo.notVisible());
            }
          },
        );

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

  bool loadProfiles(
    List<ProfileDTO> profiles,
    int nextFetchIndex,
  ) {
    int i = 0;
    _nextFetchIndex = nextFetchIndex;
    for (var e in _profileStatesNotifier!) {
      if (e.value.state == ProfileState.loading) {
        if (i < profiles.length) {
          e.value = ProfileInfo.loaded(profiles[i]);
          i++;
        } else {
          return false;
        }
      }
    }
    return true;
  }

  int get profilesInLoadingState => _profileStatesNotifier!.where((e) => e.value.state == ProfileState.loading).length;
}
