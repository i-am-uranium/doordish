import 'package:flutter/material.dart';
import 'package:js/js.dart';

import '../../api/location_provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/assets.dart';
import '../../helper/location.dart';
import '../../utils/logger.dart';
import '../common/hand_cursor_inkwell.dart';
import '../common/horizontal_spacer.dart';

class CheckoutHeader extends StatefulWidget {
  const CheckoutHeader({
    Key key,
    this.onProfileClick,
    this.onNotificationClick,
    this.onMoreClick,
  }) : super(key: key);

  final Function onProfileClick;
  final Function onNotificationClick;
  final Function onMoreClick;

  @override
  _CheckoutHeaderState createState() => _CheckoutHeaderState();
}

class _CheckoutHeaderState extends State<CheckoutHeader> {
  String currentLocation = 'India';
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit_location,
              ),
              onPressed: () {
                getCurrentPosition(
                  allowInterop(
                    (pos) {
                      logger.i('pos is $pos');
                      LocationAPI().fetchData().then((value) =>
                          setState(() => currentLocation = value.city));
                    },
                  ),
                );
              },
            ),
            const HorizontalSpacer(),
            Text(currentLocation),
          ],
        ),
        Row(
          children: [
            HandCursorInkWell(
              borderRadius: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onClick: widget.onNotificationClick,
              child: Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  Assets.notificationPng,
                  width: 24,
                  height: 24,
                  color: AppColors.black,
                ),
              ),
            ),
            HandCursorInkWell(
              borderRadius: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onClick: widget.onProfileClick,
              child: Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  Assets.femaleAvatar,
                  width: 40,
                  height: 40,
                ),
              ),
            ),
            HandCursorInkWell(
              borderRadius: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onClick: widget.onMoreClick,
              child: Container(
                width: 48,
                height: 48,
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  Icons.more_vert,
                  color: AppColors.lightGrey,
                  size: 36,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
