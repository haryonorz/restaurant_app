part of 'responses.dart';

class RestaurantsResult {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  RestaurantsResult({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) =>
      RestaurantsResult(
        error: json['error'],
        message: json['message'],
        count: json['count'],
        restaurants: List<Restaurant>.from(
          (json['restaurants'] as List).map((e) => Restaurant.fromJson(e)),
        ),
      );
}
