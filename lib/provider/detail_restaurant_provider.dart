part of 'providers.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailRestaurantProvider({
    required this.apiService,
    required this.id,
  }) {
    fetchDetailRestaurant(id);
  }

  late DetailRestaurantsResult _restaurant;
  late ResultState _state;
  late SubmitState _submitState;
  String _message = '';

  String get message => _message;

  DetailRestaurantsResult get result => _restaurant;

  ResultState get state => _state;

  SubmitState get submitState => _submitState;

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurant = await apiService.detailRestaurant(id);
      if (restaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = restaurant.message;
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurant = restaurant;
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

  Future<String?> postReview(String id, String name, String review) async {
    try {
      _submitState = SubmitState.loading;
      notifyListeners();

      final result = await apiService.postReview(id, name, review);
      if (result.error) {
        _submitState = SubmitState.error;
        notifyListeners();
        return _message = 'Error --> ${result.message}';
      } else {
        _submitState = SubmitState.success;
        notifyListeners();
        return null;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'No Internet connection. Make sure that Wi-Fi or mobile data is turned on, the try again.';
    } catch (e) {
      _submitState = SubmitState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
