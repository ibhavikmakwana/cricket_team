import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseAPI {
  static Stream<QuerySnapshot> playerStream =
      Firestore.instance.collection('player').snapshots();

  static CollectionReference reference =
      Firestore.instance.collection('player');

  static addPlayer(String name) {
    Firestore.instance.runTransaction((Transaction transaction) async {
      await reference.add({
        "name": name,
      });
    });
  }

  static removePlayer(String id) {
    Firestore.instance.runTransaction((Transaction transaction) async {
      await reference.document(id).delete().catchError((error) {
        print(error);
      });
    });
  }

  static updatePlayer(String id, String newName) {
    Firestore.instance.runTransaction((Transaction transaction) async {
      await reference.document(id).updateData({
        "name": newName,
      }).catchError((error) {
        print(error);
      });
    });
  }
}
