class LocationModel {
  String? name;
  String? formattedAddress;
  double? lat;
  double? lng;

  LocationModel({this.name, this.formattedAddress, this.lat, this.lng});

  factory LocationModel.fromJson(Map<String, dynamic> map) {
    return LocationModel(
      name: map['name'],
      formattedAddress: map['formatted_address'],
      lat: map['geometry']['location']['lat'],
      lng: map['geometry']['location']['lng'],
    );
  }

  static List<LocationModel> parseLocationList(map) {
    var list = map['results'] as List;
    return list.map((movie) => LocationModel.fromJson(movie)).toList();
  }
}