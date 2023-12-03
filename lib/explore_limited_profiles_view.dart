import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:profile_fetch/app_colors.dart';
import 'package:profile_fetch/extension_helper.dart';

import 'carousel_profile_view.dart';
import 'explore_page_state_data.dart';
import 'profile_bloc.dart';

class ExploreLimitedProfilesView extends StatefulWidget {
  final bool showIndex;
  final ProfileBloc profileBloc;

  const ExploreLimitedProfilesView({
    Key? key,
    required this.profileBloc,
    this.showIndex = false,
  }) : super(key: key);

  @override
  State<ExploreLimitedProfilesView> createState() => _ExploreLimitedProfilesViewState();
}

class _ExploreLimitedProfilesViewState extends State<ExploreLimitedProfilesView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ExplorePageStateData stateData = widget.profileBloc.explorePageNotifier.value;
    if (stateData.profileStates.isEmpty) {
      return _noDataView();
    }
    double viewPortFraction = 0.75;
    double cardWidth = MediaQuery.of(context).size.width * viewPortFraction;
    double aspectRatio = 0.75;
    double cardHeight = cardWidth / aspectRatio;
    List<Widget> dots = _pageIndicatorDots(stateData);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _carouselView(cardHeight, viewPortFraction, stateData),
        if (dots.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: dots.spaceHorizontally(8),
              ),
            ],
          )
      ].spaceVertically(20),
    );
  }

  List<Widget> _pageIndicatorDots(ExplorePageStateData stateData) {
    List<Widget> dots = [];
    for (int i = 0; i < stateData.profileStates.length; i++) {
      bool isSelected = (i == _currentIndex);
      double size = 5;
      if (isSelected) {
        size = 1.75 * size;
      }
      dots.add(
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Colors.blue : AppColors.grey400,
          ),
        ),
      );
    }
    return dots;
  }

  Center _noDataView() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'That\'s all for now!\nPlease come back after sometime.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.grey400,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CarouselSlider _carouselView(
    double cardHeight,
    double viewPortFraction,
    ExplorePageStateData value,
  ) {
    return CarouselSlider.builder(
      key: ValueKey(value.profileStates.length),
      options: CarouselOptions(
        height: cardHeight,
        enlargeCenterPage: false,
        clipBehavior: Clip.none,
        viewportFraction: viewPortFraction,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
        initialPage: _currentIndex,
        enableInfiniteScroll: false,
      ),
      itemCount: value.profileStates.length,
      itemBuilder: (context, index, realIndex, offset) {
        return CarouselProfileView(
          carouselIndex: index,
          wheelIndex: index,
          state: value.profileStates[index],
          showIndex: widget.showIndex,
          offset: offset,
          onSendRequest: () {
            bool isFirst = (index == 0);
            bool isLast = (index == value.profileStates.length - 1);
            value.removeCenterProfile(index);
            setState(() {
              if (value.profileStates.isNotEmpty) {
                if (isFirst) {
                  _currentIndex = 0;
                } else if (isLast) {
                  _currentIndex = (value.profileStates.length - 1);
                }
              }
            });
          },
        );
      },
      carouselController: value.carouselController,
    );
  }
}
