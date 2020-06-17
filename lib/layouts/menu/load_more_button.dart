import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../constants/app_colors.dart';
import '../../constants/strings.dart';
import '../../utils/logger.dart';

class LoadMoreButton extends StatelessWidget {
  const LoadMoreButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      elevation: 0,
      color: AppColors.white,
      onPressed: () {
        logger.i('Load more clicked');
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: AppColors.primaryColor),
      ),
      icon: const Icon(
        FontAwesome.refresh,
        color: AppColors.primaryColor,
        size: 16,
      ),
      label: const Text(
        Strings.loadMore,
        style: TextStyle(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
