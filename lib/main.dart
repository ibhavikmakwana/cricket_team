import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_team/add_player.dart';
import 'package:cricket_team/firebase/firebase_api.dart';
import 'package:cricket_team/firebase/player_model.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cricket',
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
      floatingActionButton: FloatingActionButton(onPressed: () {
        _navigateToAddPlayer();
      }),
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Your Team",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
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
              _buildList(context, snapshot.data.documents),
            ],
          ),
        );
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final player = Player.fromSnapshot(data);
    return Padding(
      key: ValueKey(player.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text(player.name),
        onTap: () => print(player),
      ),
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
