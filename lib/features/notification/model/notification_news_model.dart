class NotificationNewsModel {
  late String? label;
  late String? desc;
  late String? date;
  late String? imgUrl;
  NotificationNewsModel({this.label, this.desc, this.date, this.imgUrl});
  
  factory NotificationNewsModel.fromJson(Map<String, dynamic> json) => NotificationNewsModel(
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
