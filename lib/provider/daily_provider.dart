part of 'providers.dart';

class DailyProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

//   Future<bool> scheduledRestaurant(bool value) async {
//     _isScheduled = value;
//     if(_isScheduled) {
//       print('Scheduling Restaurant Activated');
//       notifyListeners();
//       return await AndroidAlarmManager
//     }
//   }
}
