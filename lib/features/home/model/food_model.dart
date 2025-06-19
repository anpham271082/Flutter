class FoodModel {
  final int? id;
  final String? title;
  final String? desc;
  final String? price;
  final double? rating;
  final String? imgUrl;
  FoodModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.price,
    required this.rating,
    required this.imgUrl,
  });
  
  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        price: json["price"],
        rating: json["rating"],
        imgUrl: json["imgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "price": price,
        "rating": rating,
        "imgUrl": imgUrl,
      };
}
