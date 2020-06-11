import 'package:flutter/material.dart';

import 'constants/app_colors.dart';
import 'layouts/checkout/checkout.dart';
import 'layouts/menu/meal_menu.dart';
import 'layouts/navigation/main_navigation_rail.dart';
import 'layouts/overview/overview.dart';
import 'model/navigation_destination.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double _navigationPlusSpaceHeight = 60;
  final double _navigationOverlayWidth = 44;

  double _mealItemDropTargetHeight = 48;
  double _navigationDestinationItemHeight = 0;
  double _navigationOverlayLefPosition;
  double _navigationRailWidth;
  double _navigationRailHeight;

  OverlayEntry _navigationTopRightCorner;
  OverlayEntry _navigationBottomRightCorner;

  List<NavigationDestination> destinations;
  int currentDestinationIndex = 0;

  @override
  void initState() {
    super.initState();
    destinations = NavigationDestination.list;
  }

  @override
  void dispose() {
    _navigationBottomRightCorner?.remove();
    _navigationBottomRightCorner?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initSizes();
    _addNRTopCurve();
    _addNRBottomCurve();
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: _navigationRailWidth,
            height: _navigationRailHeight,
            color: AppColors.navigationBackgroundColor,
            child: MainNavigationRail(
              destinations: destinations,
              onDestinationSelect: _updateNavigationDestination,
              currentIndex: currentDestinationIndex,
            ),
          ),
          _currentDestination(currentDestinationIndex),
        ],
      ),
    );
  }

  void _initSizes() {
    _navigationDestinationItemHeight = 44;
    _navigationOverlayLefPosition =
        MediaQuery.of(context).size.width * .20 - 56;
    _navigationRailWidth = MediaQuery.of(context).size.width * .20 - 30;
    _navigationRailHeight = MediaQuery.of(context).size.height;
  }

  double _getNRTopCurveHeight(List<NavigationDestination> destinations) {
    double result = 114;
    for (final destination in destinations) {
      if (!destination.selected) {
        result += _navigationPlusSpaceHeight;
      } else {
        break;
      }
    }
    return result;
  }

  double _getNRBottomCurveHeight(List<NavigationDestination> destinations) {
    return MediaQuery.of(context).size.height -
        _getNRTopCurveHeight(destinations) -
        _navigationDestinationItemHeight;
  }

  void _addNRTopCurve() {
    final overlay = Overlay.of(context);
    _navigationTopRightCorner = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 0,
          left: _navigationOverlayLefPosition,
          child: AnimatedContainer(
            width: _navigationOverlayWidth,
            height: _getNRTopCurveHeight(destinations),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(22),
              ),
            ),
          ),
        );
      },
    );
    WidgetsBinding.instance
        .addPostFrameCallback((_) => overlay.insert(_navigationTopRightCorner));
  }

  void _addNRBottomCurve() {
    final overlay = Overlay.of(context);
    _navigationBottomRightCorner = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: 0,
          left: _navigationOverlayLefPosition,
          child: AnimatedContainer(
            width: _navigationOverlayWidth,
            height: _getNRBottomCurveHeight(destinations),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(22),
              ),
            ),
          ),
        );
      },
    );
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => overlay.insert(_navigationBottomRightCorner));
  }

  void _updateNavigationDestination(int index) {
    setState(() {
      for (final destination in destinations) {
        destination.selected = false;
      }
      currentDestinationIndex = index;
    });
  }

  void _updateMealItemDropTargetHeight(double height) =>
      setState(() => _mealItemDropTargetHeight = height);

  Widget _currentDestination(int index) {
    switch (index) {
      case 0:
        return Overview(
          width: MediaQuery.of(context).size.width - _navigationRailWidth,
          height: MediaQuery.of(context).size.height,
        );
      case 1:
        return Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width -
                  _navigationRailWidth -
                  MediaQuery.of(context).size.width * .28,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.only(left: 36, top: 16, right: 24),
              color: AppColors.white,
              child: MealMenuWidget(
                onDragEnd: () => _updateMealItemDropTargetHeight(64),
                onDragComplete: () => _updateMealItemDropTargetHeight(64),
                onDragStarted: () => _updateMealItemDropTargetHeight(200),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .28,
              height: MediaQuery.of(context).size.height,
              color: AppColors.checkoutContainer,
              padding: const EdgeInsets.only(
                top: 24,
                right: 16,
              ),
              child: Checkout(
                dragTargetHeight: _mealItemDropTargetHeight,
              ),
            )
          ],
        );
      default:
        return Container();
    }
  }
}
