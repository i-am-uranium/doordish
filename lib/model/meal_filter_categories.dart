import 'package:equatable/equatable.dart';
import '../constants/assets.dart';
import 'meal_category.dart';

class MealFilterCategory extends Equatable {
  MealFilterCategory({
    this.id,
    this.name,
    this.selected,
    this.icon,
    this.category,
  });

  final int id;
  final String name;
  final String icon;
  final MealCategory category;
  bool selected;

  @override
  List<Object> get props => [
        id,
        name,
        icon,
        category,
      ];

  static List<MealFilterCategory> get list {
    return [
      MealFilterCategory(
        name: 'All',
        selected: false,
        icon: Assets.bread_1,
        category: MealCategory.all,
      ),
      MealFilterCategory(
        name: 'Sushi',
        selected: false,
        icon: Assets.sushiRool,
        category: MealCategory.lunch,
      ),
      MealFilterCategory(
        name: 'Fast Food',
        selected: false,
        icon: Assets.frenchFries,
        category: MealCategory.eveningSnack,
      ),
      MealFilterCategory(
        name: 'Burgers',
        selected: false,
        icon: Assets.burger,
        category: MealCategory.lunch,
      ),
      MealFilterCategory(
        name: 'Pizza',
        selected: false,
        icon: Assets.burger,
      ),
      MealFilterCategory(
        name: 'Coffee',
        selected: false,
        icon: Assets.coffee,
        category: MealCategory.breakfast,
      ),
      MealFilterCategory(
        name: 'Deserts',
        selected: false,
        icon: Assets.donuts,
      ),
      MealFilterCategory(
        name: 'Breakfast',
        selected: false,
        icon: Assets.bread_1,
        category: MealCategory.breakfast,
      ),
      MealFilterCategory(
        name: 'Soup',
        selected: false,
        icon: Assets.bowl,
        category: MealCategory.diet,
      ),
      MealFilterCategory(
        name: 'Vegan',
        selected: false,
        icon: Assets.kiwi,
        category: MealCategory.diet,
      ),
      MealFilterCategory(
        name: 'Dinner',
        selected: false,
        icon: Assets.cooking,
        category: MealCategory.dinner,
      ),
      MealFilterCategory(
        name: 'Healthy',
        selected: false,
        icon: Assets.chickenThigh,
        category: MealCategory.dinner,
      ),
    ];
  }

  static List<MealFilterCategory> get popularFilters => [
        MealFilterCategory(
          name: 'Burgers',
          selected: true,
          icon: Assets.burger,
        ),
        MealFilterCategory(
          name: 'Pizza',
          selected: true,
          icon: Assets.burger,
        )
      ];
}
