import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ituapp/auth.dart';
import 'package:ituapp/pages/storage_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';


class PersonalInformation extends StatefulWidget{
  PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}



class _PersonalInformationState extends State<PersonalInformation> {

  late File _image_file;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    
    final Storage storage = Storage();
    final User? user = Auth().currentUser;
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 230, 230, 1),
      appBar: AppBar(title: Text("Osobní údaje"), centerTitle: true, backgroundColor: Colors.red.shade700, ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 FutureBuilder<String>(
                    future: (user == null) || (user.photoURL == null) ? storage.downloadUrl("user.png") : Future.value(user.photoURL),
                    builder: (BuildContext context, AsyncSnapshot <String> snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const CircularProgressIndicator();
                      }else if(snapshot.hasError){
                        return Text("Error: ${snapshot.error}");
                      }else{
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(context: context, builder: ((builder) => bottomSheet(context)));
                          },
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.white,
                            backgroundImage: CachedNetworkImageProvider(snapshot.data!)
                          ),
                        );
                      }
                    }
                  ),
              ],
            ),
            
            Row(
              children: [
                Text("Zobrazené jméno:")
              ],
            ),
            
            Row(
              children: [
                Text("Email:")
              ],
            ),
            
            Row(
              children: [
                Text("Jméno:")
              ],
            )

          ],
        ),
      ),
    );
  }

  Widget bottomSheet(context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
      child: Column(
        children: <Widget>[

        Text("Změnit profilový obrázek", style: TextStyle(fontSize: 20),),
        SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          TextButton.icon(
            onPressed:() {
              takePhoto(ImageSource.camera);
            }, 
            icon: Icon(Icons.camera),
            label: Text("Kamera"),
          ),
          TextButton.icon(
            onPressed:() {
              takePhoto(ImageSource.gallery);
            },
            icon: Icon(Icons.image),
            label: Text("Galerie")
          )
        ])
        ]
      ),
    );
  } 

  void takePhoto(ImageSource source) async{
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile == null) return;
    setState(() {
      _image_file = File(pickedFile.path);
      
    });
  }
}

