import 'package:cloud_firestore/cloud_firestore.dart';

class GalleryImage {
  String? id;
  String image;

  GalleryImage({
    required this.image,
  });

  GalleryImage.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        image = doc['IMAGE'];
}

Stream<List<GalleryImage>> dbGetGallerys(String userId) async* {
  final db = FirebaseFirestore.instance;
  final stream = db.collection("/USERS/$userId/GALLERY").snapshots();

  await for (final querySnap in stream) {
    final docs = querySnap.docs;
    List<GalleryImage> gl = [];
    for (final docSnap in docs) {
      gl.add(GalleryImage.fromFirestore(docSnap));
    }
    yield gl;
  }
}
