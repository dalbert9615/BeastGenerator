import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:BeastGenerator/screens/gallery_screen.dart';
import 'package:BeastGenerator/screens/profile_screen.dart';
import 'package:BeastGenerator/screens/search_screen.dart';

String assetName(String asset) {
  if (kIsWeb) {
    return asset;
  } else {
    return "assets/$asset";
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String query = "";

  @override
  void initState() {
    super.initState();
    //si el user no esta agregarlo
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _body = [
      const SearchScreen(),
      const GalleryScreen(),
      const ProfileScreen(),
    ];

    List<String> _title = [
      /*userId ?? ""*/ "Generator",
      "My Collection",
      "My Profile",
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 144, 94, 143),
        title: Text(
          _title[selectedIndex],
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _body[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: "my collection",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "profile",
          ),
        ],
        elevation: 24,
        selectedItemColor: const Color.fromARGB(255, 144, 94, 143),
        unselectedItemColor: Colors.grey[400],
        onTap: ((index) {
          setState(() {
            selectedIndex = index;
          });
        }),
      ),
    );
  }
}
