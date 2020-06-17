import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/assets.dart';
import '../../model/address.dart';
import '../common/vertical_spacer.dart';

class SelectDeliverTime extends StatelessWidget {
  const SelectDeliverTime({
    this.addresses,
    Key key,
  }) : super(key: key);
  final List<Address> addresses;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          Assets.timeIllustration,
          width: 300,
          height: 184,
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 32,
          ),
          child: Text(
            'Which Address Do You Want to Receive Your Order?',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: .18,
              height: 1.7,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
          ),
          child: Text(
            'Choose the address where you want your order to be delivered.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.secondaryText,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: .18,
              height: 1.5,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 32,
            left: 16,
            right: 16,
          ),
          child: SizedBox(
            height: 185,
          ),
        ),
        const VerticalSpacer(
          space: 64,
        ),
      ],
    );
  }
}
