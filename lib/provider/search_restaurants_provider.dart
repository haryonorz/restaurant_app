part of 'providers.dart';

class SearchRestaurantsProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantsProvider({
    required this.apiService,
  }) {
    searchRestaurants(query);
  }

  late SearchRestaurantsResult _restaurantsResult;
  late ResultState _state;
  String _message = '';
  String _query = '';

  String get message => _message;

  String get query => _query;

  SearchRestaurantsResult get result => _restaurantsResult;

  ResultState get state => _state;

  Future<dynamic> searchRestaurants(String keyword) async {
    try {
      _state = ResultState.loading;
      _query = keyword;
      notifyListeners();

      if (keyword.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      }

      final restaurant = await apiService.searchRestaurants(keyword);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'No Internet connection. Make sure that Wi-Fi or mobile data is turned on, the try again.';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
