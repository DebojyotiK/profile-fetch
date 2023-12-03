enum ProfileState {
  notVisible,
  loading,
  loaded,
}

class ProfileDTO {
  final String imageUrl;
  final String name;

  ProfileDTO({
    required this.imageUrl,
    required this.name,
  });
}

class ProfileInfo {
  final ProfileState _state;

  ProfileState get state => _state;
  final ProfileDTO? _profileDTO;

  ProfileDTO get profileDTO => _profileDTO!;

  ProfileInfo._(this._state, this._profileDTO);

  ProfileInfo.notVisible()
      : _state = ProfileState.notVisible,
        _profileDTO = null;

  ProfileInfo.loading()
      : _state = ProfileState.loading,
        _profileDTO = null;

  ProfileInfo.loaded(ProfileDTO profileDTO)
      : _state = ProfileState.loaded,
        _profileDTO = profileDTO;
}
