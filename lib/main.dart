import 'package:flutter/material.dart';
import 'package:ituapp/firebase_options.dart';
import 'package:ituapp/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
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
