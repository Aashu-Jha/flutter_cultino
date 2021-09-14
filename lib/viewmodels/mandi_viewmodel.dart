import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cultino/helpers/db_helper.dart';
import 'package:flutter_cultino/models/mandi_model.dart';
import 'package:http/http.dart' as http;

class MandiViewModel extends ChangeNotifier {
  List<OtherMandi> _list = [];

  List<OtherMandi> get list => [..._list];

  Future<void> fetchAndSetProducts() async {
    var response = await fetchFromDatabase();
    if (response.isNotEmpty) {
      _list = response;
      notifyListeners();
    } else {
      fetchFromApi();
    }
  }

  Future<List<OtherMandi>> fetchFromDatabase() async {
    final databaseResult =
        await DBHelper.getDataFromMandiDatabase('mandi_db');

    List<OtherMandi> data = [];
    if(databaseResult.isEmpty) {
      return data;
    }

    for (var item in databaseResult) {
      data.add(
        OtherMandi(
            cropId: item["cropId"],
            district: item["district"],
            districtId: item["districtId"],
            hindiName: item["hindiName"],
            id: item["id"],
            image: item["image"],
            km: item["km"],
            lastDate: item["lastDate"],
            lat: item["lat"],
            lng: item["lng"],
            location: item["location"],
            market: item["market"],
            meters: item["meters"],
            state: item["state"],
            urlStr: item["urlStr"]),
      );
    }
    return data;
  }

  Future<void> fetchFromApi() async {
    final uri = Uri.parse(
        'https://thekrishi.com/test/mandi?lat=28.44108136&lon=77.0526054&ver=89&lang=hi&crop_id=10');

    final response = await http.get(uri, headers: {
      "Accept": "application/json",
    });

    final responseJson = utf8.decode(response.bodyBytes);

    final List<OtherMandi> data =
        mandiModelFromJson(responseJson).data.otherMandi;
    _list = data;

    for(var item in _list) {
      DBHelper.insertIntoMandiDatabase('mandi_db', {
            "cropId": item.cropId,
            "district": item.district,
            "districtId": item.districtId,
            "hindiName": item.hindiName,
            "id": item.id,
            "image": item.image,
            "km": item.km,
            "lastDate": item.lastDate,
            "lat": item.lat,
            "lng": item.lng,
            "location": item.location,
            "market": item.market,
            "meters": item.meters,
            "state": item.state,
            "urlStr": item.urlStr,
      });
    }
    
    notifyListeners();
  }

}
