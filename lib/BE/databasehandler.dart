
/*
  Author: Samuel Čus - xcussa00
  Date: December 17, 2023
  Description: This is a Flutter source file for Class representing chat users, BE
*/
import 'package:firebase_database/firebase_database.dart';


class DatabaseHandler {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  void dataWrite(String key, String values) {
    final instance = _database.child(key);
    instance.set(values);
  }

  void dataUpdate(String key, Map<String, String> values) {
    final instance = _database.child(key);
    instance.update(values);
  }

  Future<String> dataRead(String key) async {
    final value = await _database.child(key).get();
    if (value.exists) {
      return value.value.toString();
    } else {
      return 'No record has been found under this key';
    }
  }
}
