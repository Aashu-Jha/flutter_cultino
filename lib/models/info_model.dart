import 'dart:convert';


InfoModel mandiModelFromJson(String str) => InfoModel.fromJson(json.decode(str));

String mandiModelToJson(InfoModel data) => json.encode(data.toJson());

class InfoModel {
  final String id;
  final String name;
  final String emailId;
  final int gender;
  final String imagePath;

  InfoModel(
      {
      required this.id,
      required this.name,
      required this.emailId,
      required this.gender,
      required this.imagePath});

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
    id: json["id"],
      name: json["name"],
      emailId: json["emailId"],
      gender: json["gender"],
      imagePath: json["imagePath"],
  );

   Map<String, dynamic> toJson() => {
     "id": id,
        "name" : name,
        "emailId": emailId,
        "gender": gender,
        "imagePath": imagePath,
    };
}
