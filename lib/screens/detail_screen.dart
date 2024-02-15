import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_shadow/drop_shadow.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:BeastGenerator/model/image_model.dart';
import 'package:BeastGenerator/screens/main_screen.dart';

String assetName(String asset) {
  if (kIsWeb) {
    return asset;
  } else {
    return "assets/$asset";
  }
}

class DetailScreen extends StatelessWidget {
  final String galleryID;
  final String userID;

  const DetailScreen({
    Key? key,
    required this.galleryID,
    required this.userID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageDescription = "Description not available.";
    String dateCreation = "Unknown.";
    String nameCreation = "UNNAMED";
    String docID = " ";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 144, 94, 143),
        title: const Text(
          "Details",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: (() async {
                final confirm = await showDialog(
                    context: context,
                    builder: (context) => confirmDelete(context));
                final db = FirebaseFirestore.instance;
                if (confirm) {
                  db.collection("/USERS/$userID/GALLERY").doc(docID).delete();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()));
                  //Navigator.popUntil(context, ModalRoute.withName("/Gallery"));
                }
              }))
        ],
      ),
      body: StreamBuilder<List<ImageData>>(
          stream: dbGetImage(userID, galleryID),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorWidget("INTERNAL ERROR: ${snapshot.error}");
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data!;

            for (int a = 0; a < data.length; a++) {
              if (data[a].image == galleryID) {
                final d = data[a];
                a = data.length;
                imageDescription = d.description;
                dateCreation = d.date;
                docID = d.id;
                nameCreation = d.name;
              }
            }

            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 144, 94, 143),
                    ),
                    child: DropShadow(
                      offset: const Offset(-1.0, 1.0),
                      child: PinchZoom(
                        resetDuration: const Duration(milliseconds: 300),
                        maxScale: 7.0,
                        child: Image.network(
                          galleryID,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 60.0, bottom: 30.0),
                                  child: Text(
                                    nameCreation,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 40.0,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 68.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Date of entry:",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          Text(
                                            dateCreation,
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 104, 104, 104),
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        "Description:  ",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        imageDescription,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 104, 104, 104),
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))),
              ],
            );
          }),
    );
  }

  AlertDialog confirmDelete(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Confirmation",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: const Text("Delete this entry?"),
      actions: [
        TextButton(
          child: const Text(
            "Cancel",
            style: TextStyle(
                color: Color.fromARGB(255, 144, 94, 143),
                fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: const Text(
            "Delete",
            style: TextStyle(
                color: Color.fromARGB(255, 144, 94, 143),
                fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
