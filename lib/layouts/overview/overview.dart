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
        image: DecorationImage(
          image: AssetImage(
            Assets.overViewBG,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: const [
          Positioned(
            top: 200,
            left: 32,
            child: Text(
              'Secret',
              style: TextStyle(
                fontSize: 50,
                letterSpacing: 0.015,
                color: Color(0xFFC29C51),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
