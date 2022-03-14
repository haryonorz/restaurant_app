part of 'models.dart';

class Menu {
  late List<Food> foods;
  late List<Drink> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });
}

class Food {
  late String name;

  Food({
    required this.name,
  });

  Food.fromJson(Map<String, dynamic> food) {
    name = food['name'];
  }
}

class Drink {
  late String name;

  Drink({
    required this.name,
  });

  Drink.fromJson(Map<String, dynamic> drink) {
    name = drink['name'];
  }
}
