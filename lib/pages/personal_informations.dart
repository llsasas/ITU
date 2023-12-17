/**
 * 
 * */ 

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ituapp/auth.dart';
import 'package:ituapp/BE/storage_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';


class PersonalInformation extends StatefulWidget{
  PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}



class _PersonalInformationState extends State<PersonalInformation> {
  
  final ImagePicker _imagePicker = ImagePicker();
  

  @override
  Widget build(BuildContext context) {
    
    final Storage storage = Storage();
    final User? user = Auth().currentUser;
    String email = "";
    String displayName = "";
    String newEmail = "";
    String newDisplayName = "";
    
    user == null || user.email == null ? email = "" : email = user.email!;
    user == null || user.displayName == null ? displayName ="" : displayName = user.displayName!;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 230, 230, 1),
      appBar: AppBar(title: const Text("Osobní údaje"), centerTitle: true, backgroundColor: Colors.red.shade700, ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 FutureBuilder<String>(
                    future: (user == null) || (user.photoURL == null) ? storage.downloadUrl("user.png") : storage.downloadUrl(user.email!),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child:Column(
                      children: <Widget>[
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(5),
                              child: SizedBox(
                                width: 250,
                                child: TextField(
                                  onChanged: (input) => newDisplayName = input,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    border: const OutlineInputBorder(),
                                    labelText: displayName,
                                    prefix: Text("Uživatelské jméno: ")
                                    ),
                                ),
                              ),
                            )
                          ],
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(5),
                              child: SizedBox(
                                width: 250,
                                child: TextField(
                                  onChanged: (input) => newEmail = input,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    border: const OutlineInputBorder(),
                                    labelText: email,
                                    prefix: Text("Email: ")
                                    ),
                                ),
                              ),
                            )
                          ],
                        ),
                        
                      ],
                    ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: TextButton(
                      child: Text("Uložit nové údaje"), onPressed: () {
                      Auth().currentUser!.updateDisplayName(newDisplayName);
                      Auth().currentUser!.updateEmail(newEmail);
                      },
                      
                    ),
                  ),
                )
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
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
      child: Column(
        children: <Widget>[

        const Text("Změnit profilový obrázek", style: TextStyle(fontSize: 20),),
        const SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          TextButton.icon(
            onPressed:() {
              takePhoto(ImageSource.camera);
            }, 
            icon: const Icon(Icons.camera),
            label: const Text("Kamera"),
          ),
          TextButton.icon(
            onPressed:() {
              takePhoto(ImageSource.gallery);
            },
            icon: const Icon(Icons.image),
            label: const Text("Galerie")
          )
        ])
        ]
      ),
    );
  } 

  void takePhoto(ImageSource source) async{
    final pickedFile = await _imagePicker.pickImage(source: source);
    //String fileName = pickedFile!.name;
    if (pickedFile == null) return;
    setState(() {
      Storage().uploadFile(pickedFile.path, Auth().currentUser!.email! );
      Auth().currentUser!.updatePhotoURL('gs://itu-6f4f6.appspot.com/');
      
    });
  }
}

