import 'package:doordish/constants/app_colors.dart';
import 'package:doordish/constants/assets.dart';
import 'package:flutter/material.dart';

import 'navigation/main_navigation_rail.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .23,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: AppColors.navigationBackgroundColor,
              ),
              child: MainNavigationRail(),
            ),
            Image.asset(
              Assets.navigationRailBGPng,
              width: MediaQuery.of(context).size.width * .23,
              height: MediaQuery.of(context).size.height,
            ),
          ],
        ),
      ),
    );
  }
}
