class NotificationServiceModel {
  late String? label;
  late String? desc;
  late String? date;
  late String? imgUrl;
  NotificationServiceModel({this.label, this.desc, this.date, this.imgUrl});
  
  factory NotificationServiceModel.fromJson(Map<String, dynamic> json) => NotificationServiceModel(
        desc: json["desc"],
        label: json["label"],
        date: json["date"],
        imgUrl: json["imgUrl"],
      );
  Map<String, dynamic> toJson() => {
        "desc": desc,
        "label": label,
        "date": date,
        "imgUrl": imgUrl,
      };
}
