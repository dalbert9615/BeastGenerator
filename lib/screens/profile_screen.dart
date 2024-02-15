import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:BeastGenerator/widgets/text_bar.dart';

String assetName(String asset) {
  if (kIsWeb) {
    return asset;
  } else {
    return "assets/$asset";
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final db = FirebaseFirestore.instance;
    final userId = user!.email;
    final regex = RegExp(r"@");
    final nickname = userId!.split(regex)[0];

    Color c = const Color.fromARGB(255, 144, 94, 143);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 144, 94, 143),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color.fromARGB(255, 28, 28, 28),
                        width: 5)),
                child: Image.asset(
                  assetName('png/logo_white.png'),
                ),
              ),
            ),
          ),
          Expanded(
            //tronco pantalla
            flex: 3,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Nickname",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 25),
                      ),
                    ),
                    TextBar(text: nickname),
                    const SizedBox(
                      height: 40,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "E-mail",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 25),
                      ),
                    ),
                    TextBar(text: userId),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
