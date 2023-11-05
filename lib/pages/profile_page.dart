import 'package:flutter/material.dart';
import 'package:ituapp/pages/storage_handler.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({this.storage, super.key});

  final Storage? storage;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage?.downloadUrl('fun.jpg'),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Container(
              width: 250,
              height: 250,
              child: Image.network(
                snapshot.data!,
                fit: BoxFit.cover,
              ));
        }
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return CircularProgressIndicator();
        }
        return Container();
      },
    );
  }
}
