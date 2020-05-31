import 'package:flutter/material.dart';

import 'constants/app_colors.dart';
import 'constants/assets.dart';
import 'constants/strings.dart';
import 'model/navigation_destination.dart';
import 'navigation/main_navigation_rail.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<NavigationDestination> destinations = [
    NavigationDestination(
      title: Strings.overview,
      icon: Assets.overviewPng,
    ),
    NavigationDestination(
      title: Strings.menu,
      icon: Assets.menuPng,
      selected: true,
    ),
    NavigationDestination(
      title: Strings.transaction,
      icon: Assets.transactionPng,
    ),
    NavigationDestination(
      title: Strings.calendar,
      icon: Assets.calendarPng,
    ),
    NavigationDestination(
      title: Strings.testimonials,
      icon: Assets.testimonialPng,
    ),
    NavigationDestination(
      title: Strings.faq,
      icon: Assets.faqPng,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .23,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: AppColors.navigationBackgroundColor,
            ),
            child: MainNavigationRail(
              width: MediaQuery.of(context).size.width * .23,
              height: MediaQuery.of(context).size.height,
              destinations: destinations,
              onDestinationSelect: (index) {
                setState(() {
                  destinations.forEach((element) => element.selected = false);
                  destinations[index].selected = true;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
