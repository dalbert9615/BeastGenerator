import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? id;
  String email, nickname;

  Users({
    required this.email,
    required this.nickname,
  });

  Users.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        email = doc['EMAIL'],
        nickname = doc['NICKNAME'];
}

Stream<List<Users>> dbGetUsers() async* {
  final db = FirebaseFirestore.instance;
  final stream = db.collection("/USERS").snapshots();

  await for (final querySnap in stream) {
    final docs = querySnap.docs;
    List<Users> us = [];
    for (final docSnap in docs) {
      us.add(Users.fromFirestore(docSnap));
    }
    yield us;
  }
}
