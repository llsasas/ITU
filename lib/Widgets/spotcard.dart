import 'package:flutter/material.dart';
import 'package:ituapp/pages/storage_handler.dart';
import 'package:ituapp/pages/spotDescription.dart';
import 'package:ituapp/BE/spots.dart';

class SpotCard extends StatelessWidget {
  final Spot spot;
  const SpotCard({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Card(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SpotDescription(spot: spot)));
        },
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: storage.downloadUrl('fun.jpg'),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Container(
                      width: 100,
                      height: 100,
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
            const SizedBox(
              height: 10,
            ),
            Text(
              spot.name,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
