/*
  Author: Samuel Čus - xhrani03
  Date: December 17, 2023
  Description: This is a Flutter source file representing maps UI
*/
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ituapp/BE/location_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ituapp/BE/mapmarkers.dart';
import 'package:ituapp/BE/spots.dart';
import 'package:ituapp/BE/storage_handler.dart';
import 'package:ituapp/Widgets/dropdownlevel.dart';
import 'package:ituapp/Widgets/filepicker.dart';
import 'package:ituapp/Widgets/spotform.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _originController = TextEditingController();
  final TextEditingController _controllername = TextEditingController();
  final TextEditingController _controllerdescription = TextEditingController();
  static const CameraPosition _Brno = CameraPosition(
    target: LatLng(49.195061, 16.606836),
    zoom: 14.4746,
  );
  Storage storage = Storage();
  @override
  void initState() {
    super.initState();

    //_setMarker(const LatLng(37.42796133580664, -122.085749655962));
  }

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

  void _setMarker(LatLng point, String name, String description) {
    setState(() {
      mapmarkerslist.add(
        Marker(
          markerId: const MarkerId("marker"),
          infoWindow:
              InfoWindow(title: name, snippet: "Description: $description"),
          position: point,
        ),
      );
    });
  }

  void _addnewspotmap(BuildContext context, LatLng point) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(50.0),
          children: <Widget>[
            _entryField('Name', _controllername),
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
                  onPressed: () {
                    spotslist.add(Spot(
                        name: _controllername.text,
                        address: '',
                        description: _controllerdescription.text,
                        level: dropvalue,
                        picturelinks: nametopass != '' ? ["${_controllername.text}/$nametopass"] : []));
                    storage.uploadFile(
                        pathtopass, "${_controllername.text}/$nametopass");
                    nametopass = '';
                    pathtopass = '';
                    _setMarker(point, _controllername.text,
                        _controllerdescription.text);
                    Navigator.of(context).pop();
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
              child: const Text(
                "Yes",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "No",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
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
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(fontSize: 20, color: Colors.black),
                      ),
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
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 30,
                ),
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
