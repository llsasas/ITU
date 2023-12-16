import 'package:flutter/material.dart';
import 'package:ituapp/BE/spots.dart';
import 'package:ituapp/pages/storage_handler.dart';

class SpotDescription extends StatelessWidget {
  final Spot spot;
  const SpotDescription({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Spot details",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 40.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: Center(
        child: FutureBuilder(
          future: storage.downloadUrl('spot1.jpg'),
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
              return const CircularProgressIndicator();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
