import 'package:flutter/material.dart';
import 'package:ituapp/BE/storage_handler.dart';
import 'package:ituapp/Widgets/filepicker.dart';
import 'package:ituapp/BE/spots.dart';

class ModifySpotButton extends StatelessWidget {
  final Storage storage = Storage();
  final Spot spot;

  // Konstruktor pro přijímání parametru Spot
  ModifySpotButton({Key? key, required this.spot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Předávání parametru Spot do funkce pro otevření nového okna
        _openNewWindow(context, spot);
      },
      color: Colors.red,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red),
      ),
      padding: const EdgeInsets.all(15.0),
      icon: const Icon(
        Icons.add_sharp,
        size: 25.0,
        color: Colors.white,
      ),
    );
  }

  void _openNewWindow(BuildContext context, Spot spot) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          //title: const Text("Add spot"),
          contentPadding: const EdgeInsets.all(50.0),
          children: <Widget>[
            FilePickerButton(),
            const SizedBox(height: 30),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    spot.picturelinks.add("${spot.name}/$nametopass");
                    storage.uploadFile(
                        pathtopass, "${spot.name}/$nametopass");
                    nametopass = '';
                    pathtopass = '';
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Add photo",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
