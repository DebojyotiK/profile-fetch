import 'profile_state.dart';
import 'package:async/async.dart';

final List<ProfileDTO> profilesAll = [
  ProfileDTO(
    imageUrl:
        'https://images.unsplash.com/photo-1682686581221-c126206d12f0?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 1",
  ),
  ProfileDTO(
    imageUrl:
        'https://images.unsplash.com/photo-1700771266232-7a31af68eb31?q=80&w=2832&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 2",
  ),
  ProfileDTO(
    imageUrl:
        'https://images.unsplash.com/photo-1701215097228-188d262c1f6b?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 3",
  ),
  ProfileDTO(
    imageUrl:
        'https://images.unsplash.com/photo-1682686581312-506a8b53190e?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 4",
  ),
  ProfileDTO(
    imageUrl:
        'https://plus.unsplash.com/premium_photo-1663840075261-29da753918a0?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 5",
  ),
  ProfileDTO(
    imageUrl:
        'https://images.unsplash.com/photo-1701485509508-58d495844f45?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 6",
  ),
  ProfileDTO(
    imageUrl:
        'https://images.unsplash.com/photo-1701488614720-5abc272fb3d7?q=80&w=2786&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 7",
  ),
  ProfileDTO(
    imageUrl:
        'https://images.unsplash.com/photo-1701451391813-2ffa8bc04f5e?q=80&w=2391&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 8",
  ),
  ProfileDTO(
    imageUrl:
        'https://images.unsplash.com/photo-1682687981630-cefe9cd73072?q=80&w=2942&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 9",
  ),
  ProfileDTO(
    imageUrl:
        'https://images.unsplash.com/photo-1701275854308-cdc300394876?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 10",
  ),
  ProfileDTO(
    imageUrl:
        'https://images.unsplash.com/photo-1701352281350-ed4a1e76c303?q=80&w=2835&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 11",
  ),
  ProfileDTO(
    imageUrl:
        'https://images.unsplash.com/photo-1682687982141-0143020ed57a?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 12",
  ),
  ProfileDTO(
    imageUrl:
        'https://images.unsplash.com/photo-1701455857582-ed916c8c9535?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 13",
  ),
  ProfileDTO(
    imageUrl:
        'https://images.unsplash.com/photo-1701453031489-2978bc96942f?q=80&w=2835&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 14",
  ),
  ProfileDTO(
    imageUrl:
        'https://images.unsplash.com/photo-1701455516458-ae6e8999a0a0?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 15",
  ),
  ProfileDTO(
    imageUrl:
        'https://images.unsplash.com/photo-1682687220989-cbbd30be37e9?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 16",
  ),
  ProfileDTO(
    imageUrl:
        'https://plus.unsplash.com/premium_photo-1700801936521-348308ae2db3?q=80&w=2840&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    name: "Debo 17",
  ),
];

final List<ProfileDTO> profilesMini = profilesAll.sublist(0, 3);

class ProfileResult {
  final int nextIndex;
  final List<ProfileDTO> profiles;

  ProfileResult({
    required this.nextIndex,
    required this.profiles,
  });
}

class ProfileFetcher {

  // keep a reference to CancelableOperation
  CancelableOperation<ProfileResult>? _myCancelableFuture;

  Future<ProfileResult> getProfiles({
    required int currentIndex,
    required int limit,
  }) async {
    _cancelPreviousOngoingCall();
    _myCancelableFuture = CancelableOperation.fromFuture(
      _getProfilesInt(currentIndex, limit),
      onCancel: () => 'Future has been canceld',
    );
    final value = await _myCancelableFuture?.value;
    return value!;
  }

  void _cancelPreviousOngoingCall() {
    _myCancelableFuture?.cancel();
  }

  Future<ProfileResult> _getProfilesInt(int currentIndex, int limit) async {
    List<ProfileDTO> profileDatabase = List.from(profilesAll);
    List<ProfileDTO> profiles = profileDatabase.sublist(currentIndex, (currentIndex + limit).clamp(0, profileDatabase.length));
    int nextIndex = (currentIndex + limit);
    if (_isResultExhausted(nextIndex, profileDatabase)) {
      nextIndex = 0;
    }
    await Future.delayed(const Duration(seconds: 1));
    return ProfileResult(
      nextIndex: nextIndex,
      profiles: profiles,
    );
  }

  bool _isResultExhausted(int nextIndex, List<ProfileDTO> profileDatabase) => nextIndex >= profileDatabase.length;
}
