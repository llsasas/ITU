import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ituapp/BE/location_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ituapp/BE/mapmarkers.dart';
import 'package:ituapp/BE/spots.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _originController = TextEditingController();
  final TextEditingController _controllername = TextEditingController();
  final TextEditingController _controlleraddress = TextEditingController();
  final TextEditingController _controllerdescription = TextEditingController();
  static const CameraPosition _Brno = CameraPosition(
    target: LatLng(49.195061, 16.606836),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    //_setMarker(const LatLng(37.42796133580664, -122.085749655962));
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  void _setMarker(LatLng point, String name, String description) {
    setState(() {
      mapmarkerslist.add(
        Marker(
          markerId: const MarkerId("marker"),
          infoWindow: InfoWindow(title: name, snippet: "Description: $description"),
          position: point,
        ),
      );
    });
  }

  void _addnewspotmap(BuildContext context,LatLng point) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Add event"),
          // contentPadding: const EdgeInsets.all(200.0),
          children: <Widget>[
            _entryField('Name', _controllername),
            _entryField('Adress', _controlleraddress),
            _entryField('Description', _controllerdescription),
            TextButton(
              onPressed: () {
                // Zde můžete definovat akci po stisknutí tlačítka v novém okně
                spotslist.add(Spot(name: _controllername.text, address: _controlleraddress.text, description: _controllerdescription.text, level: 3));
                _setMarker(point, _controllername.text, _controllerdescription.text);
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

  void _openNewWindow(BuildContext context, LatLng point) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("New spot"),
          // contentPadding: const EdgeInsets.all(200.0),
          content: const Text("Do you want to add new spot?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _addnewspotmap(context, point);
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _originController,
                      decoration: const InputDecoration(hintText: 'Search'),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  var place =
                      await LocationService().getPlace(_originController.text);
                  _goToPlace(place);
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: mapmarkerslist,
              initialCameraPosition: _Brno,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onLongPress: (point) {
                _openNewWindow(context, point);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToPlace(
    Map<String, dynamic> place,
  ) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );
  }
}
