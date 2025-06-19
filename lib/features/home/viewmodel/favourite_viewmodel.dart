import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../model/favourite_model.dart';
class FavouriteViewModel with ChangeNotifier {
  List<FavouriteModel> _favourites = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<FavouriteModel> get favourites => _favourites;

  Future<void> fetchFavourites() async {
    try {
      _isLoading = true;
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts')
      );
      if(response.statusCode == 200){
        List<FavouriteModel> fetchedFavourites = (json.decode(response.body) as List)
          .map((favourite) => FavouriteModel.fromJson(favourite)).toList();
          _favourites = fetchedFavourites;
      }
    } catch (exc) {
      debugPrint('Error in fetchFavourites : ${exc.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchFavouritesJson() async {
    try {
      _isLoading = true;
      String jsonString = await rootBundle.loadString("assets/favourites.json");
      List<FavouriteModel> fetchedFavourites = (json.decode(jsonString) as List)
          .map((favourite) => FavouriteModel.fromJson(favourite)).toList();
          _favourites = fetchedFavourites;
      debugPrint(jsonString);
    } catch (exc) {
      debugPrint('Error in fetchFavouritesJson : ${exc.toString()}');
    }
    _isLoading = false;
    notifyListeners();
  }
}