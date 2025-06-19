import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../model/food_model.dart';
class FoodViewModel with ChangeNotifier {
  List<FoodModel> _foods = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<FoodModel> get foods => _foods;

  Future<void> fetchFoods() async {
    try {
      _isLoading = true;
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts')
      );
      if(response.statusCode == 200){
        List<FoodModel> fetchedFoods = (json.decode(response.body) as List)
          .map((favourite) => FoodModel.fromJson(favourite)).toList();
          _foods = fetchedFoods;
      }
    } catch (exc) {
      debugPrint('Error in fetchFoods : ${exc.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchFoodsJson() async {
    try {
      _isLoading = true;
      String jsonString = await rootBundle.loadString("assets/foods.json");
      List<FoodModel> fetchedFoods = (json.decode(jsonString) as List)
          .map((favourite) => FoodModel.fromJson(favourite)).toList();
          _foods = fetchedFoods;
      debugPrint(jsonString);
    } catch (exc) {
      debugPrint('Error in fetchFoodsJson : ${exc.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }
}