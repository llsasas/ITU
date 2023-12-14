import 'package:flutter/material.dart';
import 'package:ituapp/pages/friends.dart';
import 'package:ituapp/pages/personal_informations.dart';
import 'package:ituapp/pages/storage_handler.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  ImageProvider? imageFile;
  
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 230, 230, 1),
      
      body: Column(
        children: <Widget>[
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(backgroundColor: Colors.white,
                backgroundImage: AssetImage("images/user.png"),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("John Doe"),
                  Text("john.doe@gmail.com"),
                  Text("status")
                ],
              )
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalInformation()));
                      },
                      child: Container(
                        width: 300,
                        height: 100,
                        decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(20))),
                        ),
                    ),
                  ),
                   Card(
                    child: InkWell(
                      onTap:() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Friends()));
                      },
                      child: Container(
                        width: 300,
                        height: 100,
                        decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(20))),
                        ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
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

