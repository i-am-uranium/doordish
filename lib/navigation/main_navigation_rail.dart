import 'package:flutter/material.dart';

import '../common/hand_cursor_widget.dart';
import '../common/horizontal_spacer.dart';
import '../common/vertical_spacer.dart';
import '../constants/app_colors.dart';
import '../model/navigation_destination.dart';

class MainNavigationRail extends StatefulWidget {
  const MainNavigationRail({
    @required this.destinations,
    @required this.width,
    @required this.height,
    this.onDestinationSelect,
    Key key,
  }) : super(key: key);

  final List<NavigationDestination> destinations;
  final double width;
  final double height;
  final ValueChanged<int> onDestinationSelect;

  @override
  _MainNavigationRailState createState() => _MainNavigationRailState();
}

class _MainNavigationRailState extends State<MainNavigationRail> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          top: 114,
          left: 32,
        ),
        itemCount: widget.destinations.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DestinationItem(
                destination: widget.destinations[index],
                width: widget.width,
                onSelect: () => widget.onDestinationSelect(index),
              ),
              const VerticalSpacer(
                space: 16,
              ),
            ],
          );
        },
      ),
    );
  }
}

class DestinationItem extends StatelessWidget {
  const DestinationItem({
    @required this.destination,
    this.width,
    this.onSelect,
    Key key,
  }) : super(key: key);
  final NavigationDestination destination;
  final double width;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return _build(destination, context);
  }

  Widget _build(NavigationDestination destination, BuildContext context) {
    return Container(
      width: width,
      height: 44,
      decoration: BoxDecoration(
        color: destination.selected ? AppColors.white : AppColors.primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          bottomLeft: Radius.circular(22),
        ),
      ),
      child: HandCursorInkWell(
        onClick: onSelect,
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
    );
  }
}

class HandCursorInkWell extends StatelessWidget {
  const HandCursorInkWell({
    @required this.child,
    this.onClick,
    Key key,
  }) : super(key: key);
  final Widget child;
  final Function onClick;

  @override
  Widget build(BuildContext context) => _handCursorInkWell;

  Widget get _handCursorInkWell {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22),
            bottomLeft: Radius.circular(22),
          ),
        ),
        onTap: onClick,
        child: HandCursor(child: child),
      ),
    );
  }
}
