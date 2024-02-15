import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:BeastGenerator/gpt_3.dart';
import 'package:BeastGenerator/model/user_model.dart';
import 'package:intl/intl.dart';
import 'package:BeastGenerator/screens/main_screen.dart';
import 'package:BeastGenerator/config.dart'

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late TextEditingController controller = TextEditingController();
  String name = "";

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ModalRoute.of(context)!.settings.arguments as String;
    final db = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser!;
    final userId = user.email;
    final regex = RegExp(r"@");
    final nickname = userId!.split(regex)[0];
    var id;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 144, 94, 143),
        title: const Text(
          "Results",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: dbGetUsers(),
          builder: (BuildContext context, AsyncSnapshot<List<Users>> snapshot) {
            if (snapshot.hasError) {
              return ErrorWidget(snapshot.error.toString());
            }
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
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
                if (query.isNotEmpty)
                  Expanded(
                    child: FutureBuilder(
                      future: OpenAI(
                              apiKey:
                                  <Config.dalle_apiKey>)
                          .image(query),
                      //future: OpenAI(apiKey: apiKey).complete(query, 50),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return ErrorWidget(snapshot.error.toString());
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        String imageResult = snapshot.data!;
                        return Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Expanded(
                              flex: 2,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                elevation: 0,
                                clipBehavior: Clip.antiAlias,
                                margin: const EdgeInsets.only(top: 0.0),
                                child: Image.network(snapshot.data!),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                query,
                                style: const TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FloatingActionButton.large(
                                    backgroundColor: Colors.black,
                                    elevation: 0,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/Main',
                                      );
                                    },
                                    child: const Icon(Icons.close_rounded),
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  FloatingActionButton.large(
                                    backgroundColor:
                                        const Color.fromARGB(255, 144, 94, 143),
                                    onPressed: () async {
                                      final name = await showDialog<String?>(
                                          context: context,
                                          builder: (context) =>
                                              setName(context));
                                      if (name == null || name.isEmpty) return;
                                      setState(() => this.name = name);

                                      var now = new DateTime.now();
                                      var formatter =
                                          new DateFormat('dd-MM-yyyy');
                                      String formattedDate =
                                          formatter.format(now);

                                      for (int a = 0; a < user.length; a++) {
                                        if (user[a].email == userId) {
                                          db
                                              .collection("/USERS/$id/GALLERY")
                                              .add({
                                            "IMAGE": imageResult,
                                            "DESCRIPTION": query,
                                            "DATE": formattedDate,
                                            "NAME": name,
                                          });
                                        }
                                      }
                                    },
                                    child: const Icon(Icons.favorite),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
              ],
            );
          }),
    );
  }

  AlertDialog setName(BuildContext context) {
    return AlertDialog(
      title: const Text("Name"),
      content: TextField(
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Enter name'),
        controller: controller,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(controller.text);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MainScreen()));
            },
            child: const Text(
              "ADD",
              style: TextStyle(
                  color: Color.fromARGB(255, 144, 94, 143),
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
