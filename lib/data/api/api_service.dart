import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../response/responses.dart';

class ApiService {
  static String baseUrl = 'https://restaurant-api.dicoding.dev';

  String get urlImage => baseUrl + '/images/medium/';

  Client? client;
  ApiService({this.client}) {
    client ?? Client();
  }

  Future<RestaurantsResult> recommendationRestaurants() async {
    final response = await client!.get(Uri.parse(baseUrl + '/list'));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load recommendation restaurants');
    }
  }

  Future<DetailRestaurantsResult> detailRestaurant(String id) async {
    final response = await client!.get(Uri.parse(baseUrl + '/detail/' + id));
    if (response.statusCode == 200) {
      return DetailRestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurants');
    }
  }

  Future<SearchRestaurantsResult> searchRestaurants(String keyword) async {
    final response =
        await client!.get(Uri.parse(baseUrl + '/search?q=$keyword'));
    if (response.statusCode == 200) {
      return SearchRestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load search restaurants');
    }
  }

  Future<ReviewResult> postReview(
    String id,
    String name,
    String review,
  ) async {
    final response = await client!.post(
      Uri.parse(baseUrl + '/review'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'id': id,
        'name': name,
        'review': review,
      }),
    );
    if (response.statusCode == 201) {
      return ReviewResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }
}
