import 'package:doordish/constants/assets.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../model/navigation_destination.dart';
import '../common/cursor_widget.dart';
import '../common/horizontal_spacer.dart';
import '../common/vertical_spacer.dart';

class MainNavigationRail extends StatelessWidget {
  const MainNavigationRail({
    @required this.width,
    @required this.destinations,
    @required this.currentIndex,
    this.onDestinationSelect,
    Key key,
  }) : super(key: key);

  final double width;
  final List<NavigationDestination> destinations;
  final ValueChanged<int> onDestinationSelect;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 32,
          left: 54,
          child: Image.asset(
            Assets.logo,
            width: 48,
            height: 48,
            color: AppColors.white,
          ),
        ),
        Positioned(
          top: 114,
          left: 32,
          child: SizedBox(
            width: width,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                destinations[currentIndex].selected = true;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DestinationItem(
                      destination: destinations[index],
                      onSelect: () => onDestinationSelect(index),
                    ),
                    const VerticalSpacer(
                      space: 16,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class DestinationItem extends StatelessWidget {
  const DestinationItem({
    @required this.destination,
    this.onSelect,
    Key key,
  }) : super(key: key);
  final NavigationDestination destination;

  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return _build(destination, context);
  }

  Widget _build(NavigationDestination destination, BuildContext context) {
    return CursorWidget(
      child: AnimatedContainer(
        height: 44,
        decoration: BoxDecoration(
          color:
              destination.selected ? AppColors.white : AppColors.primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22),
            bottomLeft: Radius.circular(22),
          ),
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        child: InkWell(
          onTap: onSelect,
          customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22),
              bottomLeft: Radius.circular(22),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Image.asset(
                  destination.icon,
                  width: 16,
                  height: 16,
                  color: destination.selected
                      ? AppColors.primaryColor
                      : AppColors.white,
                ),
              ),
              const HorizontalSpacer(
                space: 16,
              ),
              Text(
                destination.title.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: destination.selected
                      ? AppColors.primaryColor
                      : AppColors.white,
                  letterSpacing: .88,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
