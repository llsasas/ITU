import 'package:google_maps_flutter/google_maps_flutter.dart';

const String desc = "In laoreet, magna id viverra tincidunt, sem odio bibendum justo, vel imperdiet sapien wisi sed libero. Pellentesque ipsum. Aenean id metus id velit ullamcorper pulvinar. Mauris metus. Donec iaculis gravida nulla. Nunc dapibus tortor vel mi dapibus sollicitudin. Et harum quidem rerum facilis est et expedita distinctio. Integer imperdiet lectus quis justo. In enim a arcu imperdiet malesuada. In rutrum.";

  Set<Marker> mapmarkerslist = 
{
  const Marker(markerId: MarkerId("Moravská zemská knihovna"),infoWindow: InfoWindow(title:"Moravská zemská knihovna", snippet:"Description: $desc" ), position:LatLng(49.208650, 16.594030) ),
  const Marker(markerId: MarkerId("Hlavas"),infoWindow: InfoWindow(title:"Hlavas", snippet:"Description: $desc" ), position: LatLng(49.192000, 16.612830)),
  const Marker(markerId: MarkerId("Náměstí Míru"),infoWindow: InfoWindow(title:"Náměstí Míru", snippet:"Description: $desc" ), position: LatLng(49.202280, 16.581280)),
  const Marker(markerId: MarkerId("Orel Řečkovice"),infoWindow: InfoWindow(title:"Orel Řečkovice", snippet:"Description: $desc" ), position:LatLng(49.248740, 16.579040) ),
 // Marker(markerId: const MarkerId("Santon"), position: LocationService().getlatlng("Veselka 21, 621 00 Brno-Řečkovice a Mokrá Hora")),
  const Marker(markerId: MarkerId("Plachťák"),infoWindow: InfoWindow(title:"Plachťák", snippet:"Description: $desc" ), position: LatLng(49.173370, 16.528250)),
  //const Marker(markerId: MarkerId("Olympia"), position: LatLng(49.137850, 49.137850)),
  const Marker(markerId: MarkerId("Chrlice"),infoWindow: InfoWindow(title:"Chrlice", snippet:"Description: $desc"), position: LatLng(49.137330, 16.653830),),
};