import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_app_flutter/features/google_map/model/location_model.dart';

class MapPickerViewModel with ChangeNotifier {

  StreamController<LocationModel> locationController =
      StreamController<LocationModel>.broadcast();
  LocationModel? currentLocation;
  static const mapKey = 'AIzaSyC5ZHi06UmrruUqctjzKKp8T4C0LUgrRIw';
  Future<List<LocationModel>> search(String query) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$mapKey";
    var response = await Dio().get(url);
    return LocationModel.parseLocationList(response.data);
  }

  void locationSelected(LocationModel location) {
    debugPrint("lat $location.lat, lng:$location.lng");
    locationController.sink.add(location);
  }

  void setLocationByMovingMap(LocationModel location) {
    currentLocation = location;
  }

  @override
  void dispose() {
    super.dispose();
    locationController.close();
  }
}