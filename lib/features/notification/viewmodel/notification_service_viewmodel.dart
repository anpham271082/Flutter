import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:my_app_flutter/features/notification/model/notification_service_model.dart';
class NotificationServiceViewModel with ChangeNotifier {
  List<NotificationServiceModel> _notificationsService = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<NotificationServiceModel> get notificationsService => _notificationsService;

  Future<void> fetchNotificationService() async {
    try {
      _isLoading = true;
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts')
      );
      if(response.statusCode == 200){
        List<NotificationServiceModel> fetchedNotifications = (json.decode(response.body) as List)
          .map((notification) => NotificationServiceModel.fromJson(notification)).toList();
          _notificationsService = fetchedNotifications;
      }
    } catch (exc) {
      debugPrint('Error in fetchNotificationService : ${exc.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchNotificationServiceJson() async {
    try {
      _isLoading = true;
      String jsonString = await rootBundle.loadString("assets/notification_service.json");
      List<NotificationServiceModel> fetchedNotifications = (json.decode(jsonString) as List)
          .map((notification) => NotificationServiceModel.fromJson(notification)).toList();
          _notificationsService = fetchedNotifications;
      debugPrint(jsonString);
    } catch (exc) {
      debugPrint('Error in fetchNotificationServiceJson : ${exc.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }
}