import 'package:cricket_team/firebase/firebase_api.dart';
import 'package:flutter/material.dart';

class AddPlayerDialog extends StatefulWidget {
  @override
  _AddPlayerDialogState createState() => _AddPlayerDialogState();
}

class _AddPlayerDialogState extends State<AddPlayerDialog> {
  final _formAddPlayerKey = GlobalKey<FormState>();
  String _name;

  String validateName(String value) {
    if (value.isEmpty) {
      return "Please Enter Player name.";
    } else {
      return null;
    }
  }

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
                FireBaseAPI.addPlayer(_name);
                Navigator.pop(context);
              }
            },
            child: Text(
              'SAVE',
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
