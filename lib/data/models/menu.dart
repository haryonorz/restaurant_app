part of 'models.dart';

class Menu {
  late List<Item> foods;
  late List<Item> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });
}

class Item {
  late String name;

  Item({
    required this.name,
  });

  Item.fromJson(Map<String, dynamic> item) {
    name = item['name'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
