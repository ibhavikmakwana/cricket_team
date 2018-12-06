import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseAPI {
  static Stream<QuerySnapshot> playerStream =
      Firestore.instance.collection('player').snapshots();

  static addPlayer(String name) {
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('player');
      await reference.add({
        "name": name,
      });
    });
  }
}
