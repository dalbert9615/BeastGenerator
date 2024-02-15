import 'package:cloud_firestore/cloud_firestore.dart';

class ImageData {
  String id;
  String image, description, date, name;

  ImageData({
    required this.id,
    required this.image,
    required this.description,
    required this.date,
    required this.name,
  });

  ImageData.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        image = doc['IMAGE'],
        description = doc['DESCRIPTION'],
        date = doc['DATE'],
        name = doc['NAME'];
}

Stream<List<ImageData>> dbGetImage(String userId, String galleryId) async* {
  final db = FirebaseFirestore.instance;
  final stream = db.collection("/USERS/$userId/GALLERY").snapshots();

  await for (final querySnap in stream) {
    final docs = querySnap.docs;
    List<ImageData> data = [];
    for (final docSnap in docs) {
      data.add(ImageData.fromFirestore(docSnap));
    }
    yield data;
  }
}
