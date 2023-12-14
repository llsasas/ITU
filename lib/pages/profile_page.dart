import 'package:flutter/material.dart';
import 'package:ituapp/pages/storage_handler.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({this.storage, super.key});

  final Storage? storage;

  @override
  Widget build(BuildContext context) {
    return Column(
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

    );
  }
}

