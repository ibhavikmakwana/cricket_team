import 'dart:io';

import 'package:cricket_team/firebase/firebase_api.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';

class AddPlayerDialog extends StatefulWidget {
  final String name;
  final String docId;

  AddPlayerDialog({this.name, this.docId});

  @override
  _AddPlayerDialogState createState() => _AddPlayerDialogState();
}

class _AddPlayerDialogState extends State<AddPlayerDialog> {
  final _formAddPlayerKey = GlobalKey<FormState>();
  String _name;
//  Future<File> _imageFile;

  String validateName(String value) {
    if (value.isEmpty) {
      return "Please Enter Player name.";
    } else {
      return null;
    }
  }

//  Widget _previewImage() {
//    return FutureBuilder<File>(
//        future: _imageFile,
//        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
//          if (snapshot.connectionState == ConnectionState.done &&
//              snapshot.data != null) {
//            return Image.file(snapshot.data);
//          } else if (snapshot.error != null) {
//            return const Text(
//              'Error picking image.',
//              textAlign: TextAlign.center,
//            );
//          } else {
//            return const Text(
//              'You have not yet picked an image.',
//              textAlign: TextAlign.center,
//            );
//          }
//        });
//  }

//  getImage(){
//    _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              final form = _formAddPlayerKey.currentState;
              if (form.validate()) {
                form.save();
                if (widget.name != null && widget.name.isNotEmpty) {
                  FireBaseAPI.updatePlayer(widget.docId, _name);
                } else {
                  FireBaseAPI.addPlayer(_name);
                }
                Navigator.pop(context);
              }
            },
            child: Text(
              widget.name != null && widget.name.isNotEmpty ? "UPDATE" : 'SAVE',
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: Form(
          key: _formAddPlayerKey,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Player name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            keyboardType: TextInputType.text,
            initialValue: widget.name != null && widget.name.isNotEmpty
                ? widget.name
                : "",
            validator: (value) {
              return validateName(value);
            },
            onSaved: (value) => _name = value,
          ),
        ),
      ),
    );
  }
}
