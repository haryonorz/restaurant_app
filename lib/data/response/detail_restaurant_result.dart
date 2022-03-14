part of 'responses.dart';

class DetailRestaurantsResult {
  bool error;
  String message;
  Restaurant restaurants;

  DetailRestaurantsResult({
    required this.error,
    required this.message,
    required this.restaurants,
  });

  factory DetailRestaurantsResult.fromJson(Map<String, dynamic> json) =>
      DetailRestaurantsResult(
        error: json['error'],
        message: json['message'],
        restaurants: Restaurant.fromJson(json['restaurant']),
      );
}
