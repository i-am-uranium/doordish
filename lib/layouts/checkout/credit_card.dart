import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/assets.dart';
import '../../utils/logger.dart';
import '../common/hand_cursor_inkwell.dart';
import '../common/horizontal_spacer.dart';

class CreditCard extends StatelessWidget {
  const CreditCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
        right: 16,
      ),
      width: MediaQuery.of(context).size.width * .28,
      height: 50,
      decoration: const BoxDecoration(
        color: AppColors.paymentCard,
        borderRadius: BorderRadius.all(
          Radius.zero,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            Assets.visaLogo,
            height: 34,
            width: 40,
          ),
          Row(
            children: const [
              Text(
                '*****',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              HorizontalSpacer(),
              Text(
                '*****',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              HorizontalSpacer(),
              Text(
                '*****',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              HorizontalSpacer(),
              Text(
                '5609',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const HorizontalSpacer(),
          HandCursorInkWell(
            onClick: () {
              logger.i('Edit payment options');
            },
            child: Image.asset(
              Assets.editButton,
              width: 16,
              height: 16,
            ),
          ),
        ],
      ),
    );
  }
}
