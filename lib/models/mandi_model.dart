// To parse this JSON data, do
//
//     final mandiModel = mandiModelFromJson(jsonString);

import 'dart:convert';

MandiModel mandiModelFromJson(String str) => MandiModel.fromJson(json.decode(str));

String mandiModelToJson(MandiModel data) => json.encode(data.toJson());

class MandiModel {
    MandiModel({
        required this.code,
        required this.data,
        required this.status,
    });

    final int code;
    final Data data;
    final String status;

    factory MandiModel.fromJson(Map<String, dynamic> json) => MandiModel(
        code: json["code"],
        data: Data.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "status": status,
    };
}

class Data {
    Data({
        required this.favMandi,
        required this.otherMandi,
    });

    final List<dynamic> favMandi;
    final List<OtherMandi> otherMandi;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        favMandi: List<dynamic>.from(json["fav_mandi"].map((x) => x)),
        otherMandi: List<OtherMandi>.from(json["other_mandi"].map((x) => OtherMandi.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "fav_mandi": List<dynamic>.from(favMandi.map((x) => x)),
        "other_mandi": List<dynamic>.from(otherMandi.map((x) => x.toJson())),
    };
}

class OtherMandi {
    OtherMandi({
        required this.cropId,
        required this.district,
        required this.districtId,
        required this.hindiName,
        required this.id,
        required this.image,
        required this.km,
        required this.lastDate,
        required this.lat,
        required this.lng,
        required this.location,
        required this.market,
        required this.meters,
        required this.state,
        required this.urlStr,
    });

    final int cropId;
    final String district;
    final int districtId;
    final String hindiName;
    final int id;
    final String image;
    final double km;
    final String lastDate;
    final double lat;
    final double lng;
    final String location;
    final String market;
    final double meters;
    final String state;
    final String urlStr;

    factory OtherMandi.fromJson(Map<String, dynamic> json) => OtherMandi(
        cropId: json["crop_id"],
        district: json["district"],
        districtId: json["district_id"],
        hindiName: json["hindi_name"],
        id: json["id"],
        image: json["image"],
        km: json["km"].toDouble(),
        lastDate: json["last_date"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        location: json["location"],
        market: json["market"],
        meters: json["meters"].toDouble(),
        state: json["state"],
        urlStr: json["url_str"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "crop_id": cropId,
        "district": district,
        "district_id": districtId,
        "hindi_name": hindiName,
        "id": id,
        "image": image,
        "km": km,
        "last_date": lastDate,
        "lat": lat,
        "lng": lng,
        "location": location,
        "market": market,
        "meters": meters,
        "state": state,
        "url_str": urlStr,
    };
}
