import 'package:flutter/cupertino.dart';
import 'package:flutter_cultino/helpers/db_helper.dart';
import 'package:flutter_cultino/models/info_model.dart';

class InfoViewModel extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<InfoModel> _list = [];

  List<InfoModel> get list => [..._list];

  InfoModel findById(String id) {
    return _list.firstWhere((element) => element.id == id);
  }

  Future<void> addInfoCard(InfoModel newInfoCard) async {
    newInfoCard = InfoModel(
      id: DateTime.now().toIso8601String(),
      name: newInfoCard.name,
      emailId: newInfoCard.emailId,
      gender: newInfoCard.gender,
      imagePath: newInfoCard.imagePath,
    );
    _list.add(newInfoCard);

    DBHelper.insert('user_info', {
      "id": newInfoCard.id,
      "name": newInfoCard.name,
      "emailId": newInfoCard.emailId,
      "gender": newInfoCard.gender,
      "imagePath": newInfoCard.imagePath,
    });
    notifyListeners();
  }

  Future<void> getInfoCards() async {
    final dataList = await DBHelper.getData('user_info');
    _list = dataList
        .map((item) => InfoModel(
            id: item['id'],
            name: item['name'],
            emailId: item['emailId'],
            gender: item['gender'],
            imagePath: item['imagePath']))
        .toList();
        print(_list.length);
    notifyListeners();
  }
}
