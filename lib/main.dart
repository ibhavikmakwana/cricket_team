import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_team/add_player.dart';
import 'package:cricket_team/firebase/firebase_api.dart';
import 'package:cricket_team/firebase/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cricket',
      theme: ThemeData(
        // Define the default Brightness and Colors
        brightness: Brightness.dark,
        splashColor: Colors.black12,
        primaryColor: Colors.cyan[600],
        accentColor: Colors.cyan[600],
        // Define the default Font Family
        fontFamily: 'Raleway',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildBody(context)),
      floatingActionButton: buildAddPlayerFab(),
    );
  }

  buildAddPlayerFab() {
    return FloatingActionButton(
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: () {
        _navigateToAddPlayer();
      },
      child: Icon(Icons.add),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FireBaseAPI.playerStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 8),
                child: Text(
                  "Your Team",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "${snapshot.data.documents.length.toString()} Members",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              _buildPlayerList(context, snapshot.data.documents),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlayerList(
      BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20.0),
      children:
          snapshot.map((data) => _buildPlayerItem(context, data)).toList(),
    );
  }

  Widget _buildPlayerItem(BuildContext context, DocumentSnapshot data) {
    final player = Player.fromSnapshot(data);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Slidable.builder(
        delegate: SlidableStrechDelegate(),
        secondaryActionDelegate: new SlideActionBuilderDelegate(
            actionCount: 2,
            builder: (context, index, animation, renderingMode) {
              if (index == 0) {
                return new IconSlideAction(
                  caption: 'Edit',
                  color: Colors.blue,
                  icon: Icons.edit,
                  onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddPlayerDialog(
                                docId: data.documentID,
                                name: player.name,
                              ),
                          fullscreenDialog: true,
                        ),
                      ),
                  closeOnTap: false,
                );
              } else {
                return new IconSlideAction(
                  caption: 'Delete',
                  closeOnTap: false,
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () =>
                      _buildConfirmationDialog(context, data.documentID),
                );
              }
            }),
        key: Key(player.name),
        child: ListTile(
          title: Text(player.name),
          onTap: () => print(player),
        ),
      ),
    );
  }

  Future<bool> _buildConfirmationDialog(
      BuildContext context, String documentID) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete'),
          content: Text('Player will be deleted'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
                child: Text('Delete'),
                onPressed: () {
                  FireBaseAPI.removePlayer(documentID);
                  Navigator.of(context).pop(true);
                }),
          ],
        );
      },
    );
  }

  void _navigateToAddPlayer() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddPlayerDialog(),
        fullscreenDialog: true,
      ),
    );
  }
}
