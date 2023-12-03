import 'package:flutter/material.dart';
import 'package:profile_fetch/profile_bloc.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  final ProfileBloc _profileBloc = ProfileBloc();


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
