import 'distance_range.dart';
import 'meal_filter_categories.dart';

class MealFilter {
  MealFilter({
    this.categories,
    this.distanceRange,
    this.minPrice,
    this.maxPrice,
  });

  List<MealFilterCategory> categories;
  DistanceRange distanceRange;
  double minPrice;
  double maxPrice;
}
