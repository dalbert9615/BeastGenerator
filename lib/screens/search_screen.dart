import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:BeastGenerator/widgets/text_editor_bar.dart';

String assetName(String asset) {
  if (kIsWeb) {
    return asset;
  } else {
    return "assets/$asset";
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Container(
              height: 250,
              width: 250,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 26, 26, 26),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset(
                  assetName('png/logo_bw.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "GET SOME BEASTS!",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
          ),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 50, left: 50),
            child: Text(
              "Try with mousecat, or pinkvampire. This enhances creativity, by getting pets created randomly from an AI. Try an have fun!",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Row(
              children: [
                Expanded(
                  child: TextEditorBar(
                    onNewMessage: (String query) {
                      setState(() => query = query);
                      Navigator.pushNamed(
                        context,
                        '/Results',
                        arguments: query,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
