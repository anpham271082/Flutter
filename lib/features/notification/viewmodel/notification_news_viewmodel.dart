import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:my_app_flutter/features/notification/model/notification_news_model.dart';
class NotificationNewsViewModel with ChangeNotifier {
  List<NotificationNewsModel> _notificationsNews = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<NotificationNewsModel> get notificationsNews => _notificationsNews;

  Future<void> fetchNotificationNews() async {
    try {
      _isLoading = true;
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts')
      );
      if(response.statusCode == 200){
        List<NotificationNewsModel> fetchedNotifications = (json.decode(response.body) as List)
          .map((notification) => NotificationNewsModel.fromJson(notification)).toList();
          _notificationsNews = fetchedNotifications;
      }
    } catch (exc) {
      debugPrint('Error in fetchNotificationNews : ${exc.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }
  Future<void> fetchNotificationNewsJson() async {
    try {
      _isLoading = true;
      String jsonString = await rootBundle.loadString("assets/notification_news.json");
      List<NotificationNewsModel> fetchedNotifications = (json.decode(jsonString) as List)
          .map((notification) => NotificationNewsModel.fromJson(notification)).toList();
          _notificationsNews = fetchedNotifications;
      debugPrint(jsonString);
    } catch (exc) {
      debugPrint('Error in fetchNotificationNewsJson : ${exc.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }
}