import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../constants/app_colors.dart';
import '../../constants/strings.dart';
import '../../utils/logger.dart';
import '../common/horizontal_spacer.dart';

class OrderDeliveryDetails extends StatelessWidget {
  const OrderDeliveryDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                Strings.myOrder,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlatButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  logger.i('on edit button click');
                },
                child: const Text(
                  Strings.edit,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: AppColors.primaryColorLight,
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  MaterialCommunityIcons.clock,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
              ),
            ),
            const HorizontalSpacer(),
            const Text(
              '02.30 PM',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: AppColors.primaryColorLight,
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  MaterialCommunityIcons.map_marker,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
              ),
            ),
            const HorizontalSpacer(),
            const Text(
              '69 7th Ave S, New York, NY 10014',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              color: AppColors.primaryColorLight,
              child: const SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  MaterialCommunityIcons.chat,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
              ),
            ),
            const HorizontalSpacer(),
            const Text(
              'Dial me for order specification',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
