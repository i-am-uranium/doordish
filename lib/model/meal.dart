import 'package:equatable/equatable.dart';

import '../constants/assets.dart';
import 'meal_category.dart';
import 'meal_quantity.dart';

class Meal extends Equatable {
  Meal({
    this.id,
    this.name,
    this.description,
    this.rating,
    this.imageUrl,
    this.price,
    this.quantity,
    this.backgroundColorHex,
    this.liked,
    this.discount,
    this.discountType,
    this.categories,
  });

  final int id;
  final double discount;
  final String discountType;
  final String name;
  final String description;
  final double rating;
  final String imageUrl;
  final int price;
  final MealQuantity quantity;
  final String backgroundColorHex;
  final List<MealCategory> categories;
  bool liked;

  @override
  List<Object> get props => [
        name,
        description,
        rating,
        imageUrl,
        price,
        quantity,
        backgroundColorHex,
        liked,
        mealQuantityUnit,
        categories,
      ];

  String get mealQuantityUnit {
    switch (quantity.type) {
      case MealQuantityType.gm:
        return 'g';
        break;
      case MealQuantityType.kg:
        return 'kg';
        break;
      case MealQuantityType.ml:
        return 'ml';
        break;
      case MealQuantityType.ltr:
        return 'l';
        break;
    }
    return '';
  }

  static List<Meal> get list {
    return [
      Meal(
        id: 1,
        name: 'Cabbage Salad',
        description: 'Cabbage Salad',
        rating: 4.2,
        liked: false,
        imageUrl: Assets.cabbageSalad,
        price: 190,
        quantity: MealQuantity(
          value: 250,
          type: MealQuantityType.gm,
        ),
        backgroundColorHex: 'FFE9F8',
        categories: const [
          MealCategory.lunch,
          MealCategory.dinner,
          MealCategory.diet,
          MealCategory.afterTraining,
        ],
      ),
      Meal(
        id: 2,
        name: 'Noodle Salad',
        description: 'Noodle Salad',
        rating: 4.5,
        liked: false,
        imageUrl: Assets.noodleSalad,
        price: 210,
        quantity: MealQuantity(
          value: 300,
          type: MealQuantityType.gm,
        ),
        backgroundColorHex: 'FFF3E9',
        categories: const [
          MealCategory.lunch,
          MealCategory.dinner,
          MealCategory.diet,
          MealCategory.afterTraining,
        ],
      ),
      Meal(
        id: 3,
        name: 'Vegetable Mix',
        description: 'Cabbage Salad',
        rating: 5,
        liked: false,
        imageUrl: Assets.vegetableMix,
        price: 229,
        quantity: MealQuantity(
          value: 400,
          type: MealQuantityType.gm,
        ),
        backgroundColorHex: 'E9FFFF',
        categories: const [
          MealCategory.lunch,
          MealCategory.dinner,
          MealCategory.diet,
          MealCategory.afterTraining,
        ],
      ),
      Meal(
        id: 4,
        name: 'Seafood Soup',
        description: 'Seafood Soup',
        rating: 4.4,
        liked: false,
        imageUrl: Assets.seafoodSoup,
        price: 310,
        quantity: MealQuantity(
          value: 350,
          type: MealQuantityType.gm,
        ),
        backgroundColorHex: 'E9F7FF',
        categories: const [
          MealCategory.lunch,
          MealCategory.diet,
        ],
      ),
      Meal(
        id: 5,
        name: 'Bean Soup',
        description: 'Bean Soup',
        rating: 4.9,
        liked: true,
        imageUrl: Assets.beanSoup,
        price: 210,
        quantity: MealQuantity(
          value: 350,
          type: MealQuantityType.gm,
        ),
        backgroundColorHex: 'F6FFE9',
        categories: const [
          MealCategory.lunch,
          MealCategory.diet,
        ],
      ),
      Meal(
        id: 6,
        name: 'Stewed Vegetable',
        description: 'Stewed Vegetable',
        rating: 3.9,
        liked: false,
        imageUrl: Assets.vegetableMix,
        price: 199,
        quantity: MealQuantity(
          value: 400,
          type: MealQuantityType.gm,
        ),
        backgroundColorHex: 'ECF0FF',
        categories: const [
          MealCategory.lunch,
          MealCategory.diet,
        ],
      ),
      Meal(
        id: 7,
        name: 'Chicken Soup',
        description: 'Chicken Soup',
        rating: 4.2,
        liked: false,
        imageUrl: Assets.chickenSoup,
        price: 310,
        quantity: MealQuantity(
          value: 350,
          type: MealQuantityType.gm,
        ),
        backgroundColorHex: 'FFE9E9',
        categories: const [
          MealCategory.eveningSnack,
        ],
      ),
      Meal(
        id: 8,
        name: 'Roast Potatoes',
        description: 'Roast Potatoes',
        rating: 4.4,
        liked: false,
        imageUrl: Assets.roastPotatoes,
        price: 235,
        quantity: MealQuantity(
          value: 300,
          type: MealQuantityType.gm,
        ),
        backgroundColorHex: 'FFFEE9',
        categories: const [
          MealCategory.afterTraining,
        ],
      ),
      Meal(
        id: 9,
        name: 'Okroshka',
        description: 'Okroshka',
        rating: 3.2,
        liked: false,
        imageUrl: Assets.okroshka,
        price: 269,
        quantity: MealQuantity(
          value: 350,
          type: MealQuantityType.gm,
        ),
        backgroundColorHex: 'FFE9F6',
        categories: const [
          MealCategory.breakfast,
        ],
      ),
    ];
  }
}
