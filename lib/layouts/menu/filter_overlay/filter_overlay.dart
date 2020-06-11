import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/strings.dart';
import '../../../model/distance_range.dart';
import '../../../model/food_categories.dart';
import '../../../model/meal_filter.dart';
import '../../../utils/logger.dart';
import '../../common/horizontal_spacer.dart';
import '../../common/vertical_spacer.dart';

class FilterOverlay extends StatefulWidget {
  const FilterOverlay({
    Key key,
    this.onCloseButtonClick,
    this.onApplyFilterClick,
  }) : super(key: key);
  final Function onCloseButtonClick;
  final ValueChanged<MealFilter> onApplyFilterClick;

  @override
  _FilterOverlayState createState() => _FilterOverlayState();
}

class _FilterOverlayState extends State<FilterOverlay> {
  List<FoodCategories> _categoryList;
  List<DistanceRange> _distanceRanges;
  RangeValues _priceRangeValue = const RangeValues(147, 395);
  RangeLabels _rangeLabels;
  double priceRangeStartPadding = 32;
  double priceRangeEndPadding = 32;
  double minPrice = 120;
  double maxPrice = 450;
  int divisions = 12;

  @override
  void initState() {
    super.initState();
    _rangeLabels = RangeLabels(
        '${Strings.rupeeSymbol} ${_priceRangeValue.start}',
        '${Strings.rupeeSymbol} ${_priceRangeValue.end}');
    _categoryList = FoodCategories.list;
    _distanceRanges = DistanceRange.list;
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.secondaryText,
      ),
    );
  }

  Widget _clearAllButton(Function onClick) {
    return FlatButton(
      onPressed: onClick,
      child: Text(
        'Clear all',
        style: TextStyle(
          fontSize: 12,
          color: AppColors.secondaryText.withOpacity(.8),
        ),
      ),
    );
  }

  Widget _filterSection(String title, Function onClick) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 24,
      color: AppColors.white,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _sectionTitle(title),
          _clearAllButton(onClick),
        ],
      ),
    );
  }

  Widget get _header {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 64,
      color: AppColors.primaryColor,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Filter',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            FlatButton(
              onPressed: () {
                logger.i('Reset all button click');
                _restAll();
              },
              child: const Text(
                'Reset',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _restAll() {
    setState(() {
      for (final category in _categoryList) {
        category.selected = false;
      }
      _priceRangeValue = const RangeValues(147, 395);
      _rangeLabels = RangeLabels(
          '${Strings.rupeeSymbol} ${_priceRangeValue.start}',
          '${Strings.rupeeSymbol} ${_priceRangeValue.end}');
      for (final distanceRange in _distanceRanges) {
        distanceRange.selected = false;
      }
    });
  }

  void _resetCategories() {
    setState(() {
      for (final category in _categoryList) {
        category.selected = false;
      }
    });
  }

  void _resetPriceRange() {
    setState(() {
      _priceRangeValue = const RangeValues(159, 400);
      _rangeLabels = const RangeLabels(
          '${Strings.rupeeSymbol} 159', '${Strings.rupeeSymbol} 400');
    });
  }

  void _resetDistanceRange() {
    setState(() {
      for (final distanceRange in _distanceRanges) {
        distanceRange.selected = false;
      }
    });
  }

  Widget get _categories {
    return _filterSection('Categories', () {
      logger.i('Categories: reset button click');
      _resetCategories();
    });
  }

  Widget get _chooseYourPriceRange {
    return _filterSection('Choose your Price Range', () {
      logger.i('ChooseYourPriceRange: reset button click');
      _resetPriceRange();
    });
  }

  Widget get _distanceFromYourLocation {
    return _filterSection('Distance from your Location', () {
      logger.i('DistanceFromYourLocation: reset button click');
      _resetDistanceRange();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _header,
        const VerticalSpacer(
          space: 24,
        ),
        _categories,
        const VerticalSpacer(
          space: 24,
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: _categoryList.length,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2 / .8,
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) => Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: !_categoryList[index].selected
                    ? AppColors.primaryColor
                    : AppColors.white,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            elevation: 0,
            color: _categoryList[index].selected
                ? AppColors.primaryColor
                : AppColors.white,
            child: Center(
              child: InkWell(
                onTap: () {
                  logger.i('On Item Click');
                  if (_categoryList[index].selected) {
                    setState(() {
                      _categoryList[0].selected = false;
                      _categoryList[index].selected = false;
                    });
                    return;
                  }
                  setState(() {
                    if (index == 0) {
                      _categoryList.forEach((element) {
                        element.selected = true;
                      });
                    } else {
                      _categoryList[index].selected = true;
                    }
                  });
                },
                child: Text(
                  _categoryList[index].name,
                  style: TextStyle(
                    fontSize: 12,
                    color: !_categoryList[index].selected
                        ? AppColors.primaryColor
                        : AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        const VerticalSpacer(
          space: 24,
        ),
        _chooseYourPriceRange,
        const VerticalSpacer(
          space: 16,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: priceRangeStartPadding,
            right: priceRangeEndPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _rangeLabels.start,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
              Text(
                _rangeLabels.end,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
        RangeSlider(
          values: _priceRangeValue,
          labels: _rangeLabels,
          min: minPrice,
          max: maxPrice,
          divisions: divisions,
          activeColor: AppColors.primaryColor,
          onChanged: (newValue) {
            logger.i('On price range change $newValue');
            setState(
              () {
                _priceRangeValue = newValue;
                _rangeLabels = RangeLabels(
                  '${Strings.rupeeSymbol} ${newValue.start.floor().toString()}',
                  '${Strings.rupeeSymbol} ${newValue.end.floor().toString()}',
                );
              },
            );
          },
        ),
        const VerticalSpacer(
          space: 24,
        ),
        _distanceFromYourLocation,
        const VerticalSpacer(
          space: 16,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _distanceRanges.length,
            padding: const EdgeInsets.only(left: 16, right: 16),
            itemBuilder: (context, index) => Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: !_distanceRanges[index].selected
                      ? AppColors.primaryColor
                      : AppColors.white,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              elevation: 0,
              color: _distanceRanges[index].selected
                  ? AppColors.primaryColor
                  : AppColors.white,
              child: SizedBox(
                width: 64,
                height: 32,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      logger.i('On Item Click');
                      setState(() {
                        for (final element in _distanceRanges) {
                          element.selected = false;
                        }
                        _distanceRanges[index].selected = true;
                      });
                    },
                    child: Text(
                      '${_distanceRanges[index].min}-${_distanceRanges[index].max}${_distanceRanges[index].unit}',
                      style: TextStyle(
                        fontSize: 12,
                        color: !_distanceRanges[index].selected
                            ? AppColors.primaryColor
                            : AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const VerticalSpacer(
          space: 24,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 72,
                height: 36,
                child: RaisedButton(
                  elevation: 0,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      color: AppColors.primaryColor,
                      width: .5,
                    ),
                  ),
                  onPressed: () {
                    logger.i('on apply click');
                    widget.onCloseButtonClick();
                  },
                  child: const Text('Cancel',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryColor,
                      )),
                ),
              ),
              const HorizontalSpacer(),
              SizedBox(
                width: 276,
                height: 36,
                child: RaisedButton(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPressed: () {
                    final MealFilter filter = MealFilter()
                      ..categories = _categoryList
                          .where((element) => element.selected)
                          .toList();
                    final DistanceRange distanceRange = _distanceRanges
                        .firstWhere((element) => element.selected,
                            orElse: () => null);
                    if (distanceRange != null) {
                      filter.distanceRange = distanceRange;
                    }
                    filter
                      ..minPrice = _priceRangeValue.start.floor()
                      ..maxPrice = _priceRangeValue.end.floor();
                    widget.onApplyFilterClick(filter);
                  },
                  child: const Text('Apply',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.white,
                      )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
