// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cultino/models/info_model.dart';
import 'package:flutter_cultino/viewmodels/info_viewmodel.dart';
import 'package:flutter_cultino/widgets/image_input.dart';
import 'package:flutter_cultino/widgets/info_tile.dart';
import 'package:provider/provider.dart';
import 'dart:core';

class FormBox extends StatefulWidget {
  const FormBox({Key? key}) : super(key: key);

  @override
  _FormBoxState createState() => _FormBoxState();
}

class _FormBoxState extends State<FormBox> {
  File? _pickedImage;

  //either be 0 for male or 1 for female
  int? _radioVal;

  final _formKey = GlobalKey<FormState>();
  var _editedInfoCard =
      InfoModel(id: '', name: '', emailId: '', gender: -1, imagePath: '');

  @override
  void initState() {
    getInitData();
    super.initState();
  }

  Future<void> getInitData() async {
    await Provider.of<InfoViewModel>(context, listen: false).getInfoCards();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Cultino'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildForm(_selectImage),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                      onPressed: _saveInfoCard,
                      icon: const Icon(Icons.done),
                      label: const Text('Submit')),
                ],
              ),
            ),
          ),
          Expanded(
            child: Consumer<InfoViewModel>(
              builder: (ctx, cardData, _) {
                return ListView.builder(
                    itemCount: cardData.list.length,
                    itemBuilder: (ctx, i) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: InfoTile(cardData: cardData.list[i]),
                        ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Form _buildForm(Function onSelectImage) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Name'),
            ),
            keyboardType: TextInputType.name,
            onSaved: (value) {
              _editedInfoCard = InfoModel(
                  id: _editedInfoCard.id,
                  name: value!,
                  emailId: _editedInfoCard.emailId,
                  gender: _editedInfoCard.gender,
                  imagePath: _editedInfoCard.imagePath);
            },
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'Required Field';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text('Email-ID')),
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) {
              _editedInfoCard = InfoModel(
                  id: _editedInfoCard.id,
                  name: _editedInfoCard.name,
                  emailId: value!,
                  gender: _editedInfoCard.gender,
                  imagePath: _editedInfoCard.imagePath);
            },
            validator: (value) {
              if (EmailValidator.validate(value!)) {
                return null;
              } else {
                return 'Enter a valid email address';
              }
            },
          ),
          Row(
            children: [
              const Text('Gender:  '),
              Radio(
                value: 0,
                groupValue: _radioVal,
                onChanged: (int? value) {
                  if (value != null) {
                    setState(() {
                      _radioVal = value;
                    });
                  }
                },
              ),
              const Text('Male '),
              Radio(
                value: 1,
                groupValue: _radioVal,
                onChanged: (int? value) {
                  if (value != null) {
                    setState(() {
                      _radioVal = value;
                    });
                  }
                },
              ),
              const Text('Female '),
            ],
          ),
          ImageInput(onSelectImage: onSelectImage),
        ],
      ),
    );
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _saveInfoCard() {
    if (_pickedImage == null ||
        _radioVal == null ||
        !_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill out fields')));
      return;
    }

    _formKey.currentState!.save();
    _editedInfoCard = InfoModel(
        id: '',
        name: _editedInfoCard.name,
        emailId: _editedInfoCard.emailId,
        gender: _radioVal!,
        imagePath: _pickedImage!.path);

    Provider.of<InfoViewModel>(context, listen: false)
        .addInfoCard(_editedInfoCard);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Data Saved')));
  }
}
