import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:BeastGenerator/firebase_options.dart';
import 'package:BeastGenerator/screens/main_screen.dart';
import 'package:BeastGenerator/screens/gallery_screen.dart';
import 'package:BeastGenerator/screens/result_screen.dart';

import 'package:BeastGenerator/widgets/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const AuthGate(
      app: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/Main',
      routes: {
        '/Main': (context) => const MainScreen(),
        '/Results': (context) => const ResultScreen(),
        '/Gallery': (context) => const GalleryScreen(),
      },
    );
  }
}
