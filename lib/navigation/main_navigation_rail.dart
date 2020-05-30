import 'package:doordish/common/horizontal_spacer.dart';
import 'package:flutter/material.dart';

class MainNavigationRail extends StatefulWidget {
  MainNavigationRail({Key key}) : super(key: key);

  @override
  _MainNavigationRailState createState() => _MainNavigationRailState();
}

class _MainNavigationRailState extends State<MainNavigationRail> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 114,
          left: 48,
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 40,
            width: MediaQuery.of(context).size.width * .1,
            child: ListView(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 16,
                    ),
                    HorizontalSpacer(),
                    Text(
                      'OVERVIEW',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: .88,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
