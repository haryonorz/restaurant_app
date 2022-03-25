import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/response/responses.dart';

import 'fetch_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('recommendationRestaurant', () {
    test('return a List Restaurant if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(Uri.parse(ApiService.baseUrl + '/list'))).thenAnswer(
          (_) async => http.Response(
              '{"error": false,"message": "success","count": 20,"restaurants": []}',
              200));

      expect(await ApiService(client: client).recommendationRestaurants(),
          isA<RestaurantsResult>());
    });
    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockClient();

      when(client.get(Uri.parse(ApiService.baseUrl + '/list')))
          .thenAnswer((_) async => http.Response('Not Found', 200));
      expect(ApiService(client: client).recommendationRestaurants(),
          throwsException);
    });
  });
}
