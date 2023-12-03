import 'package:flutter/material.dart';
import 'package:profile_fetch/app_button.dart';
import 'package:profile_fetch/extension_helper.dart';
import 'package:profile_fetch/profile_state.dart';

class CarouselProfileView extends StatefulWidget {
  final int index;
  final bool showIndex;
  final ValueNotifier<ProfileInfo> state;
  final VoidCallback? onSendRequest;

  const CarouselProfileView({
    Key? key,
    required this.index,
    this.showIndex = false,
    required this.state,
    this.onSendRequest,
  }) : super(key: key);

  @override
  State<CarouselProfileView> createState() => _CarouselProfileViewState();
}

class _CarouselProfileViewState extends State<CarouselProfileView> {
  @override
  void initState() {
    super.initState();
    widget.state.addListener(_refreshView);
  }

  @override
  void dispose() {
    super.dispose();
    widget.state.removeListener(_refreshView);
  }

  void _refreshView() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    bool isProfileFetched = (widget.state.value.state == ProfileState.loaded);
    return AspectRatio(
      aspectRatio: 0.75,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffd7d7d7)),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffd7d7d7),
              offset: Offset(-2, 1),
              blurRadius: 13,
              spreadRadius: 5,
            ),
          ],
          borderRadius: _borderRadius,
        ),
        child: ClipRRect(
          borderRadius: _borderRadius,
          child: Container(
            color: const Color(0xffe5e5e5),
            child: AnimatedOpacity(
              opacity: isProfileFetched ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: isProfileFetched ? _profileView() : Container(),
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius get _borderRadius => BorderRadius.circular(12);

  Widget _profileView() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: Image.network(
            widget.state.value.profileDTO.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        if (widget.showIndex)
          Positioned(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${widget.index}",
                style: TextStyle(
                  fontSize: 48,
                  inherit: false,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4
                    ..color = Colors.black,
                ),
              ),
            ),
          ),
        if (widget.showIndex)
          Positioned(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "${widget.index}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  inherit: false,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.state.value.profileDTO.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppButton.primary(
                        text: 'Send Request',
                        onTap: widget.onSendRequest,
                      ),
                    )
                  ],
                )
              ].spaceVertically(12),
            ),
          ),
        ),
      ],
    );
  }
}
