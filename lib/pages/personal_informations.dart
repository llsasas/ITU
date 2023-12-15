import 'package:flutter/material.dart';
import 'package:ituapp/pages/storage_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';


class PersonalInformation extends StatelessWidget{
  PersonalInformation({super.key});
  
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
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
                  future: storage.downloadUrl("fun.jpg"),
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
              ],
              ),
          ],
        ),
      ),
    );
  }


}

