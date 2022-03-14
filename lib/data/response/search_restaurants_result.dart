part of 'responses.dart';

class SearchRestaurantsResult {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  SearchRestaurantsResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory SearchRestaurantsResult.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantsResult(
        error: json['error'],
        founded: json['founded'],
        restaurants: List<Restaurant>.from(
          (json['restaurants'] as List).map((e) => Restaurant.fromJson(e)),
        ),
      );
}
