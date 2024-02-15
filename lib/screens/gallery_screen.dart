import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:BeastGenerator/model/gallery_model.dart';
import 'package:BeastGenerator/model/image_model.dart';
import 'package:BeastGenerator/model/user_model.dart';
import 'package:BeastGenerator/widgets/image_card_widget.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;
    final userId = user.email;
    final regex = RegExp(r"@");
    final nickname = userId!.split(regex)[0];
    var id;
    String nameCreation = " ";

    return Scaffold(
      body: StreamBuilder(
          stream: dbGetUsers(),
          builder: (BuildContext context, AsyncSnapshot<List<Users>> snapshot) {
            if (snapshot.hasError) {
              return ErrorWidget(snapshot.error.toString());
            }
            if (!snapshot.hasData) {
              return const CircularProgressIndicator(
                  color: Color.fromARGB(255, 144, 94, 143));
            }
            final user = snapshot.data!;

            bool userExists = false;
            for (int a = 0; a < user.length; a++) {
              if (user[a].email == userId) {
                final u = user[a];
                a = user.length;
                userExists = true;
                id = u.id;
              }
            }
            if (!userExists) {
              db.collection("/USERS").add({
                "EMAIL": userId,
                "NICKNAME": nickname,
              });
            }

            return Column(
              children: [
                StreamBuilder(
                  stream: dbGetGallerys(id),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<GalleryImage>> snapshot) {
                    if (snapshot.hasError) {
                      return ErrorWidget("INTERNAL ERROR: ${snapshot.error}");
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 144, 94, 143)));
                    }
                    final galleryImage = snapshot.data;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 15.0, top: 25.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 1 / 1.5,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 5),
                          itemCount: galleryImage?.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return StreamBuilder(
                                stream:
                                    dbGetImage(id, galleryImage![index].image),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return ErrorWidget(
                                        "INTERNAL ERROR: ${snapshot.error}");
                                  }
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  final data = snapshot.data!;

                                  for (int a = 0; a < data.length; a++) {
                                    if (data[a].image ==
                                        galleryImage[index].image) {
                                      final d = data[a];
                                      a = data.length;
                                      nameCreation = d.name;
                                    }
                                  }
                                  return ImageCard(
                                    imageCode: galleryImage[index].image,
                                    galleryImage: const [],
                                    userID: id,
                                    index: index,
                                    name: nameCreation,
                                  );
                                });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }),
    );
  }
}
