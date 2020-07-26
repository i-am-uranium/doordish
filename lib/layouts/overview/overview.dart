import 'package:doordish/layouts/common/floating_food_card.dart';
import 'package:doordish/model/meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../constants/app_colors.dart';
import '../../constants/assets.dart';
import '../../constants/strings.dart';
import '../../utils/logger.dart';
import '../common/hand_cursor_inkwell.dart';
import '../common/horizontal_spacer.dart';
import '../common/vertical_spacer.dart';

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
      color: AppColors.white,
      child: Stack(
        children: [
          Positioned(
            top: 32,
            child: Image.asset(
              Assets.pumpkinSoup,
              height: 470,
              width: 441,
            ),
          ),
          Positioned(
            top: 32,
            right: 64,
            child: Row(
              children: [
                HandCursorInkWell(
                  onClick: () {
                    logger.i('On facebook click');
                  },
                  child: const Icon(
                    SimpleLineIcons.social_facebook,
                    size: 20,
                  ),
                ),
                const HorizontalSpacer(
                  space: 20,
                ),
                HandCursorInkWell(
                  onClick: () {
                    logger.i('On facebook click');
                  },
                  child: const Icon(
                    SimpleLineIcons.social_instagram,
                    size: 20,
                  ),
                ),
                const HorizontalSpacer(
                  space: 20,
                ),
                HandCursorInkWell(
                  onClick: () {
                    logger.i('On facebook click');
                  },
                  child: const Icon(
                    SimpleLineIcons.social_twitter,
                    size: 20,
                  ),
                ),
                const HorizontalSpacer(
                  space: 20,
                ),
                HandCursorInkWell(
                  onClick: () {
                    logger.i('On facebook click');
                  },
                  child: const Icon(
                    SimpleLineIcons.social_youtube,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 456,
            child: SizedBox(
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: Strings.ifYouCant,
                      style: TextStyle(
                        fontSize: 26,
                        height: 1.2,
                        letterSpacing: .18,
                        color: AppColors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: Strings.lickYour,
                          style: TextStyle(
                            fontSize: 26,
                            height: 1.2,
                            letterSpacing: .18,
                            color: AppColors.primaryColor,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      text: Strings.fingers,
                      style: TextStyle(
                        fontSize: 26,
                        height: 1.2,
                        letterSpacing: .18,
                        color: AppColors.primaryColor,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: Strings.enjoyYourHalf,
                          style: TextStyle(
                            fontSize: 26,
                            height: 1.2,
                            letterSpacing: .18,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalSpacer(space: 16),
                  const Text(
                    Strings.overviewDescription,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      letterSpacing: .18,
                      height: 1.4,
                    ),
                  ),
                  const VerticalSpacer(space: 16),
                  const Text(
                    Strings.overviewDescription2,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      letterSpacing: .18,
                      height: 1.4,
                    ),
                  ),
                  const VerticalSpacer(space: 24),
                  Row(
                    children: [
                      Image.asset(
                        Assets.awards,
                        width: 60,
                        height: 60,
                      ),
                      const HorizontalSpacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Tasted Yummy',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          VerticalSpacer(),
                          Text(
                            'Best Dish Award 2020',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 64,
            top: 364,
            child: FloatingMealCard(
              meal: Meal(
                name: 'Pumpkin Soup',
                price: 359,
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                imageUrl: Assets.pumpkinSoup,
              ),
            ),
          ),
          Positioned(
            top: 32,
            right: 0,
            child: Image.asset(
              Assets.slideVeg,
              height: 470,
            ),
          ),
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
