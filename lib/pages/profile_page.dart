/*
  Author: Ondra Potoček - xpotoc08
  Date: December 17, 2023
  Description: This is a Flutter source file for Class representing profile page
*/
import 'package:flutter/material.dart';
import 'package:ituapp/pages/personal_informations.dart';
import 'package:ituapp/BE/storage_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ituapp/auth.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  ImageProvider? imageFile;
  
  

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    final User? user = Auth().currentUser;
    String email = "";
    String displayName = "";
    String status = "";
    user == null || user.email == null ? email = "" : email = user.email!;
    user == null || user.displayName == null ? displayName ="" : displayName = user.displayName!;
    
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 230, 230, 1),
      
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              
              const Padding(
                padding:  EdgeInsets.all(10.0),
                child:  Row(children: [Text("Můj profil", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),)],),
              ),
              
              Row(
                children: <Widget>[
                  const Spacer(),
                  FutureBuilder<String>(
                    future: (user == null) || (user.photoURL == null) ? storage.downloadUrl("user.png") : storage.downloadUrl(user.email!),
                    builder: (BuildContext context, AsyncSnapshot <String> snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const CircularProgressIndicator();
                      }else if(snapshot.hasError){
                        return Text("Error: ${snapshot.error}");
                      }else{
                        return CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.white,
                          backgroundImage: CachedNetworkImageProvider(snapshot.data!)
                        );
                      }
                    }
                    ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(displayName, style: TextStyle(fontSize: 18),),
                      Text(email, style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                      Card(
                        child: InkWell(
                          onTap:() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalInformation()));
                          },
                          child: Container(
                            width: 300,
                            height: 100,
                            decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(20))),
                            child: const Row(
                              children: <Widget>[
                                  Spacer(),
                                  Icon(Icons.person),
                                  Spacer(),
                                  Text("Spravovat osobní údaje", style: TextStyle(fontSize: 14),),
                                  Spacer(),
                                  Icon(Icons.arrow_right_alt_rounded),
                                  Spacer()
                                ]
                              ),
                            ),
                        ),
                      ),
                       
                    ],
                  )
                ],
              ),
              
            ],
          ),
        ),
      )
    );
  }

  
}



/**
 * return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
              const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 30.0, 
              ),
              ),
            ),
            Spacer(),
            FutureBuilder(
      future: storage?.downloadUrl('fun.jpg'),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Container(
              width: 100,
              height: 100,
              child:ClipOval(
                child:Image.network(
                snapshot.data!,
                fit: BoxFit.cover,
              ), 
              ),
              );
        }
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return CircularProgressIndicator();
        }
        return Container();
      },
    )
          ],
        ),

      ],
 */

