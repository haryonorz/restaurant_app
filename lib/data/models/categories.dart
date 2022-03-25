part of 'models.dart';

class Categories {
  late String name;

  Categories({
    required this.name,
  });

  Categories.fromJson(Map<String, dynamic> category) {
    name = category['name'];
  }
}
