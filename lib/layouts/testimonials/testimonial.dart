import 'package:doordish/constants/assets.dart';
import 'package:doordish/layouts/common/floating_food_card.dart';
import 'package:doordish/layouts/common/horizontal_spacer.dart';
import 'package:doordish/layouts/menu/meal_menu_item.dart';
import 'package:doordish/model/meal.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../model/testimonial.dart';
import 'testimonial_list.dart';

class Testimonial extends StatelessWidget {
  const Testimonial({
    @required this.width,
    @required this.height,
    @required this.onReadMoreClick,
    Key key,
  }) : super(key: key);
  final double width;
  final double height;
  final ValueChanged<UserTestimonial> onReadMoreClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppColors.white,
      child: Stack(
        children: [
          Positioned(
            left: 48,
            top: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '“',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(
                      width: 400,
                      child: const Text(
                        'I Love Greek Salad, consectetur adipiscing elit. Nulla at interdum morbi blandit leo interdum congue. Scelerisque est tempor, nam egestas amet scelerisque nulla nec. Egestas id egestas quam elit quam nec felis. Tristique molestie mi donec vitae gravida',
                        maxLines: 10,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: .18,
                          height: 1.3,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ),
                  ],
                ),
                HorizontalSpacer(
                  space: 100,
                ),
                SizedBox(
                  width: 400,
                  height: 350,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 100,
                        child: Card(
                          elevation: 0,
                          child: Image.asset(
                            Assets.blogThree,
                            fit: BoxFit.cover,
                            width: 270,
                            height: 250,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: FloatingMealCard(
                          meal: Meal(
                            name: 'Pancake Honey',
                            description:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Placerat cursus id id porttito',
                            price: 139,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 0,
                        child: SizedBox(
                          width: 200,
                          height: 48,
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: BorderSide(
                                color: Colors.yellowAccent,
                                width: .5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  Assets.starRatingPng,
                                  width: 16,
                                  height: 16,
                                ),
                                Image.asset(
                                  Assets.starRatingPng,
                                  width: 16,
                                  height: 16,
                                ),
                                Image.asset(
                                  Assets.starRatingPng,
                                  width: 16,
                                  height: 16,
                                ),
                                Image.asset(
                                  Assets.starRatingPng,
                                  width: 16,
                                  height: 16,
                                ),
                                Image.asset(
                                  Assets.starRatingPng,
                                  width: 16,
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 48,
            bottom: 0,
            child: SizedBox(
              height: 400,
              width: width - 32,
              child: TestimonialList(
                testimonials: UserTestimonial.list,
                onReadMoreClick: onReadMoreClick,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
