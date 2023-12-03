import 'package:flutter/material.dart';
import 'package:profile_fetch/app_colors.dart';
import 'package:profile_fetch/explore_profiles_wheel_view.dart';
import 'package:profile_fetch/profile_bloc.dart';

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
          return ExploreProfilesWheelView(
            profileBloc: _profileBloc,
            showIndex: _showIndex,
          );
        }
        return const SizedBox();
      },
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
}
