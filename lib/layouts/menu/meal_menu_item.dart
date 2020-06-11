import 'package:doordish/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../constants/app_colors.dart';
import '../../model/meal.dart';
import '../common/cursor_widget.dart';
import '../common/horizontal_spacer.dart';
import '../common/vertical_spacer.dart';

class MealMenuItem extends StatefulWidget {
  const MealMenuItem({
    @required this.meal,
    this.onSelect,
    this.onLikeClick,
    this.onDragStarted,
    this.onDragEnd,
    this.onDragComplete,
    Key key,
  })  : assert(meal != null, 'meal cannot be null'),
        super(key: key);
  final Meal meal;
  final ValueChanged<bool> onLikeClick;
  final Function onSelect;
  final Function onDragStarted;
  final Function onDragEnd;
  final Function onDragComplete;

  @override
  _MealMenuItemState createState() => _MealMenuItemState();
}

class _MealMenuItemState extends State<MealMenuItem> {
  double cardElevation = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget get _feedback {
    final Meal meal = widget.meal;
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: 228,
        height: 64,
        child: Card(
          color: AppColors.hexToColor(meal.backgroundColorHex),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 12,
                ),
                child: Image.asset(
                  meal.imageUrl,
                ),
              ),
              const HorizontalSpacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const VerticalSpacer(
                    space: 4,
                  ),
                  Text(
                    '${meal.quantity.value}${meal.mealQuantityUnit}',
                    style: TextStyle(
                      color: AppColors.darken(
                        AppColors.hexToColor(meal.backgroundColorHex),
                        20,
                      ),
                      fontSize: 12,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Draggable<Meal>(
      feedback: _feedback,
      data: widget.meal,
      childWhenDragging: _build,
      onDragStarted: widget.onDragStarted,
      onDragCompleted: widget.onDragComplete,
      onDraggableCanceled: (velocity, offset) {
        if (mounted) {
          widget.onDragEnd();
        }
      },
      child: _build,
    );
  }

  Widget get _build {
    return CursorWidget(
      cursorType: CursorType.grab,
      onExit: (event) {
        if (cardElevation != 0) {
          setState(() {
            cardElevation = 0;
          });
        }
      },
      onHover: (event) {
        if (cardElevation == 0) {
          setState(() {
            cardElevation = 16;
          });
        }
      },
      child: Card(
        color: AppColors.hexToColor(widget.meal.backgroundColorHex),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: cardElevation,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onSelect,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingWidget(
                        rating: widget.meal.rating,
                      ),
                      LikedWidget(
                        liked: widget.meal.liked,
                        onLikeClick: widget.onLikeClick,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                    right: 16,
                  ),
                  child: Image.asset(
                    widget.meal.imageUrl,
                    width: 70,
                    height: 70,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      Text(
                        widget.meal.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          color: AppColors.black,
                          fontSize: 16,
                        ),
                      ),
                      const HorizontalSpacer(),
                      Container(
                        width: 56,
                        height: 30,
                        padding: const EdgeInsets.only(
                          left: 4,
                          right: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            '''${widget.meal.quantity.value}${widget.meal.mealQuantityUnit}''',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: AppColors.darken(
                                  AppColors.hexToColor(
                                      widget.meal.backgroundColorHex),
                                  20),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      '₹${widget.meal.price}',
                      style: const TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LikedWidget extends StatelessWidget {
  const LikedWidget({
    this.liked = false,
    Key key,
    this.onLikeClick,
  }) : super(key: key);
  final bool liked;
  final ValueChanged<bool> onLikeClick;

  @override
  Widget build(BuildContext context) {
    return CursorWidget(
      child: Container(
        width: 26,
        height: 26,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => onLikeClick(!liked),
          child: Icon(
            liked ? FontAwesome.heart : SimpleLineIcons.heart,
            color: liked ? AppColors.red : AppColors.black,
            size: 11,
          ),
        ),
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    @required this.rating,
    Key key,
  })  : assert(rating != null, 'rating cannot be null'),
        super(key: key);
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 41,
      height: 26,
      padding: const EdgeInsets.only(
        left: 4,
        right: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          Image.asset(
            Assets.starRatingPng,
            width: 9,
            height: 9,
          ),
          const HorizontalSpacer(
            space: 4,
          ),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.white,
            ),
          )
        ],
      ),
    );
  }
}
