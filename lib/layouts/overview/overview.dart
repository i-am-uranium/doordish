import 'package:doordish/constants/app_colors.dart';
import 'package:doordish/layouts/common/horizontal_spacer.dart';
import 'package:doordish/layouts/common/vertical_spacer.dart';
import 'package:flutter/material.dart';

import '../../constants/assets.dart';

class Overview extends StatefulWidget {
  const Overview({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);
  final double width;
  final double height;

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: const BoxDecoration(
        color: AppColors.white,
        image: DecorationImage(
          image: AssetImage(
            Assets.overViewBG,
          ),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 24,
              ),
              child: Image.asset(
                Assets.clientLogo,
                height: 64,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
