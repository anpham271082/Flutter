import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../model/notification_my_self_model.dart';
class NotificationMySelfViewModel with ChangeNotifier {
  List<NotificationMySelfModel> _notificationsMySelf = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<NotificationMySelfModel> get notificationsMySelf => _notificationsMySelf;

  Future<void> fetchNotificationMySelf() async {
    try {
      _isLoading = true;
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts')
      );
      if(response.statusCode == 200){
        List<NotificationMySelfModel> fetchedNotifications = (json.decode(response.body) as List)
          .map((notification) => NotificationMySelfModel.fromJson(notification)).toList();
          _notificationsMySelf = fetchedNotifications;
      }
    } catch (exc) {
      debugPrint('Error in fetchNotificationMySelf : ${exc.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchNotificationMySelfJson() async {
    try {
      _isLoading = true;
      String jsonString = await rootBundle.loadString("assets/notification_my_self.json");
      List<NotificationMySelfModel> fetchedNotifications = (json.decode(jsonString) as List)
          .map((notification) => NotificationMySelfModel.fromJson(notification)).toList();
          _notificationsMySelf = fetchedNotifications;
      debugPrint(jsonString);
    } catch (exc) {
      debugPrint('Error in fetchNotificationMySelfJson : ${exc.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }
}