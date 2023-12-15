import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ituapp/BE/location_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

  Set<Marker> _markers = Set<Marker>();

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _originController = TextEditingController();


  static const CameraPosition _Brno = CameraPosition(
    target: LatLng(49.195061, 16.606836),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    //_setMarker(const LatLng(37.42796133580664, -122.085749655962));
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('marker'),
          position: point,
        ),
      );
    });
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
                 var place = await LocationService().getPlace(_originController.text);
                _goToPlace(place);
                  
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: _markers,
              initialCameraPosition: _Brno,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: (point) {
                  //TODO
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
/*
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),
          25),
    );*/
  }
}