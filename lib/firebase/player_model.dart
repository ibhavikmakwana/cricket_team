import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String name;
  final DocumentReference reference;

  Player.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        name = map['name'];

  Player.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => name;
}