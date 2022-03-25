part of 'utils.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().topHeadlines();
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
