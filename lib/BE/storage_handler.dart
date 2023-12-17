/*
  Author: Samuel Čus - xcussa00
  Date: December 17, 2023
  Description: This is a Flutter source file for BE functionality, Firebase storage
*/
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Storage{
  final firebase_storage.FirebaseStorage storage = 
    firebase_storage.FirebaseStorage.instance;

    Future <String> downloadUrl(String imageName) async
    {
      String downloadURL = await storage.ref(imageName).getDownloadURL();
      return downloadURL;
    }
    Future <void> uploadFile(
      String filepath,
      String filename,
      //String type,
    ) async {
      File file = File(filepath);
      try
      {
       storage.ref(filename).putFile(file);
      } on firebase_core.FirebaseException catch(e)
      {
        print(e);
      }
    }
}