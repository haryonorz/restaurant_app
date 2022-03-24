part of 'models.dart';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late String? address;
  late List<Categories>? categories;
  late num rating;
  late Menu? menu;
  late List<Review>? reviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    this.address,
    this.categories,
    required this.rating,
    this.menu,
    this.reviews,
  });

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    address = restaurant['address'];
    categories = restaurant['categories'] != null
        ? List<Categories>.from(
            (restaurant['categories'] as List)
                .map((e) => Categories.fromJson(e)),
          )
        : null;
    rating = restaurant['rating'];
    menu = restaurant['menus'] != null
        ? Menu(
            foods: List<Item>.from(
              (restaurant['menus']['foods'] as List)
                  .map((e) => Item.fromJson(e)),
            ),
            drinks: List<Item>.from(
              (restaurant['menus']['drinks'] as List)
                  .map((e) => Item.fromJson(e)),
            ))
        : null;
    reviews = restaurant['customerReviews'] != null
        ? List<Review>.from(
            (restaurant['customerReviews'] as List)
                .map((e) => Review.fromJson(e)),
          )
        : null;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> menus = {
      "foods": menu?.foods.map((food) => food.toJson()).toList(),
      "drinks": menu?.drinks.map((drink) => drink.toJson()).toList(),
    };

    return {
      "id": id,
      "name": name,
      "description": description,
      "pictureId": pictureId,
      "city": city,
      "address": address,
      "categories": categories?.map((categorie) => categorie.toJson()).toList(),
      "rating": rating,
      "menu": menus,
      "reviews": reviews?.map((review) => review.toJson()).toList(),
    };
  }
}
