/*
  Author: Ondra Potoček - xpotoc08
  Date: December 17, 2023
*/
import 'package:flutter/material.dart';
import 'package:ituapp/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyA4rgQCtgpqt7GZu7o8Ubi7Dy8Rk7SkZ6I",
          authDomain: "itu-6f4f6.firebaseapp.com",
          databaseURL:
              "https://itu-6f4f6-default-rtdb.europe-west1.firebasedatabase.app",
          projectId: "itu-6f4f6",
          storageBucket: "itu-6f4f6.appspot.com",
          messagingSenderId: "483894081462",
          appId: "1:483894081462:web:618fa7e26b922892ed7317",
          measurementId: "G-G5XZ384L9C"));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const WidgetTree(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Slider(value: 0.0, onChanged: (double value) {}),
      ],
    );
  }
}

/*
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';


// ...


await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

);
*/
