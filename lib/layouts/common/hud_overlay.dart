import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class HUDOverlay extends StatefulWidget {
  const HUDOverlay({
    @required this.child,
    Key key,
    this.color,
  }) : super(key: key);
  final Widget child;
  final Color color;

  @override
  _HUDOverlayState createState() => _HUDOverlayState();
}

class _HUDOverlayState extends State<HUDOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimation;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    opacityAnimation = Tween<double>(begin: 0, end: 0.4).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..drive(
        AlignmentTween(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );
    controller
      ..addListener(() => setState(() {}))
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.lightGrey.withOpacity(opacityAnimation.value),
      child: Align(
        child: ScaleTransition(
          alignment: Alignment.topRight,
          scale: scaleAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}
