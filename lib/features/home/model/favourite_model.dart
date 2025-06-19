class FavouriteModel {
  final int? id;
  final String? title;
  final String? desc;
  final String? label;
  final String? price;
  final double? rating;
  final String? imgUrl;
  FavouriteModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.label,
    required this.price,
    required this.rating,
    required this.imgUrl,
  });
  
  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        label: json["label"],
        price: json["price"],
        rating: json["rating"],
        imgUrl: json["imgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "label": label,
        "price": price,
        "rating": rating,
        "imgUrl": imgUrl,
      };
}
