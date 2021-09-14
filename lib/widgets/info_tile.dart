import 'package:flutter/material.dart';
import 'package:flutter_cultino/models/info_model.dart';

class InfoTile extends StatelessWidget {
  final InfoModel cardData;
  const InfoTile({
    Key? key,
    required this.cardData
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Text(cardData.gender == 0 ? 'Male' : 'Female'),
      tileColor: Colors.blueAccent,
      title: Text(cardData.name),
      subtitle: Text(cardData.emailId),
    );
  }
}