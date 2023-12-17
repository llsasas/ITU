/*
  Author: Jan Hranička - xhrani03
  Date: December 17, 2023
  Description: This is a Flutter source file representing custom widget form used for adding spot from the list of spots
*/
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ituapp/BE/spots.dart';
import 'package:ituapp/BE/mapmarkers.dart';
import 'package:ituapp/BE/location_services.dart';
import 'package:ituapp/BE/storage_handler.dart';
import 'package:ituapp/Widgets/dropdownlevel.dart';
import 'package:ituapp/Widgets/filepicker.dart';

num dropvalue = 1;
String spotnametopass = '';

class AddSpotButton extends StatelessWidget {
  final TextEditingController _controllername = TextEditingController();
  final TextEditingController _controlleraddress = TextEditingController();
  final TextEditingController _controllerdescription = TextEditingController();
  final Storage storage = Storage();

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return Container(
      width: 200,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Zde zavoláte funkci pro otevření nového okna
        _openNewWindow(context);
      },
      color: Colors.white,
      padding: const EdgeInsets.all(15.0),
      icon: const Icon(
        Icons.add_sharp,
        size: 35.0,
        color: Colors.white,
      ),
    );
  }

  void _openNewWindow(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          //title: const Text("Add spot"),
          contentPadding: const EdgeInsets.all(50.0),
          children: <Widget>[
            _entryField('Name', _controllername),
            const SizedBox(height: 10),
            _entryField('Adress', _controlleraddress),
            const SizedBox(height: 10),
            _entryField('Description', _controllerdescription),
            const SizedBox(height: 10),
            DropDownLevel(),
            const SizedBox(height: 20),
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
                  onPressed: () async {
                    LatLng coord = await LocationService()
                        .getlatlng(_controlleraddress.text);
                    String desc = _controllerdescription.text;
                    spotslist.add(Spot(
                        name: _controllername.text,
                        address: _controlleraddress.text,
                        description: _controllerdescription.text,
                        level: dropvalue,
                        picturelinks: nametopass != ''
                            ? ["${_controllername.text}/$nametopass"]
                            : []));
                    storage.uploadFile(
                        pathtopass, "${_controllername.text}/$nametopass");
                    nametopass = '';
                    pathtopass = '';
                    mapmarkerslist.add(
                      Marker(
                        markerId: const MarkerId("marker"),
                        infoWindow: InfoWindow(
                            title: _controllername.text,
                            snippet: "Description: $desc"),
                        position: coord,
                      ),
                    );
                    Navigator.of(context).pop(); // Zavře nové okno
                  },
                  child: const Text(
                    "Add spot",
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
