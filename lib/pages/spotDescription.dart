import 'package:flutter/material.dart';
import 'package:ituapp/BE/spots.dart';
import 'package:ituapp/BE/storage_handler.dart';
import 'package:ituapp/Widgets/modify_photos.dart';

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
            fontSize: 25.0,
            color: Color.fromRGBO(238, 230, 230, 1),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              spot.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              spot.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Level:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (spot.level == 1) ...[
                  const Icon(Icons.circle, size: 30, color: Colors.green),
                  const Icon(Icons.circle, size: 30, color: Colors.grey),
                  const Icon(Icons.circle, size: 30, color: Colors.grey),
                ] else if (spot.level == 2) ...[
                  const Icon(Icons.circle, size: 30, color: Colors.orange),
                  const Icon(Icons.circle, size: 30, color: Colors.orange),
                  const Icon(Icons.circle, size: 30, color: Colors.grey),
                ] else if (spot.level == 3) ...[
                  const Icon(Icons.circle, size: 30, color: Colors.red),
                  const Icon(Icons.circle, size: 30, color: Colors.red),
                  const Icon(Icons.circle, size: 30, color: Colors.red),
                ],
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              'Spot Photos:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: spot.picturelinks.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                    future: storage.downloadUrl(spot.picturelinks[index]),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return Container(
                          width: 250,
                          height: 250,
                          margin: const EdgeInsets.only(right: 8.0),
                          child: Image.network(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          !snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }
                      return Container();
                    },
                  );
                },
              ),
            ),
            ModifySpotButton(spot: spot,)
          ],
        ),
      ),
    );
  }
}
