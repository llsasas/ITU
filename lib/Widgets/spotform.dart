import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ituapp/BE/spots.dart';
import 'package:ituapp/BE/mapmarkers.dart';
import 'package:ituapp/BE/location_services.dart';

class AddSpotButton extends StatelessWidget {
  final TextEditingController _controllername = TextEditingController();
  final TextEditingController _controlleraddress = TextEditingController();
  final TextEditingController _controllerdescription = TextEditingController();

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
          title: const Text("Add spot"),
          contentPadding: const EdgeInsets.all(50.0),
          children: <Widget>[
            _entryField('Name', _controllername),
            _entryField('Adress', _controlleraddress),
            _entryField('Description', _controllerdescription),
            TextButton(
              onPressed: () async {
                LatLng coord =
                    await LocationService().getlatlng(_controlleraddress.text);
                String desc = _controllerdescription.text;
                spotslist.add(Spot(
                    name: _controllername.text,
                    address: _controlleraddress.text,
                    description: _controllerdescription.text,
                    level: 3));
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
              child: const Text("Add spot"),
            ),
            TextButton(
              onPressed: () {
                // Zde můžete definovat akci po stisknutí tlačítka v novém okně
                Navigator.of(context).pop(); // Zavře nové okno
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
