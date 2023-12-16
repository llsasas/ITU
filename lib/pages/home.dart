import 'package:flutter/material.dart';
import 'package:ituapp/pages/googlemaps.dart';
import 'package:ituapp/pages/profile_page.dart';
import 'package:ituapp/pages/storage_handler.dart';
import 'package:ituapp/Widgets/calendar.dart';
import 'package:ituapp/auth.dart';
import 'package:ituapp/pages/chat.dart';
import 'package:ituapp/BE/spots.dart';
import 'package:ituapp/Widgets/spotcard.dart';
import 'package:ituapp/Widgets/spotform.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

num displayed_items = spotslist.length;
bool spots = true;
class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _signOutButt() {
    return ElevatedButton(
        onPressed: signOut,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent.shade700,
            elevation: 0 // Změňte tuto barvu podle svých potřeb
            ),
        child: const Text(
          'Sign out',
          style: TextStyle(color: Colors.white),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Spot Center",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
              leading: spots ? AddSpotButton() : null,
              actions: [
                _signOutButt(),
              ],
              centerTitle: true,
              backgroundColor: Colors.redAccent.shade700,
            ),
            body: <Widget>[
               Container(
                color: const Color.fromRGBO(238, 230, 230, 1),
                padding: const EdgeInsets.all(30),
                child: ListView.builder(
                  itemCount: spotslist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SpotCard(spot: spotslist[index]);
                  },
                ),
              ),
             
              Container(
                color: Colors.blue,
                alignment: Alignment.center,
                child: MapSample(),
              ),
              Container(
                child: 
                  TableEvents()
              
              ),
              Chat(),
              ProfilePage(),
            ][_currentIndex],
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                setState(() {
                  index == 0  ? spots= true : spots = false;
                  _currentIndex = index;
                });
              },
              backgroundColor: Colors.white,
              selectedIndex: _currentIndex,
              destinations: const <Widget>[
                NavigationDestination(
                    icon: Icon(Icons.list),
                    selectedIcon: Icon(Icons.list, color: Colors.red),
                    label: "Spoty"),
                NavigationDestination(
                    icon: Icon(Icons.map_outlined),
                    selectedIcon: Icon(Icons.map, color: Colors.red),
                    label: "Mapa"),
                NavigationDestination(
                    icon: Icon(
                      Icons.calendar_month_outlined,
                    ),
                    selectedIcon: Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.red,
                    ),
                    label: "Kalendář"),
                NavigationDestination(
                    icon: Icon(
                      Icons.chat_outlined,
                    ),
                    selectedIcon: Icon(
                      Icons.chat,
                      color: Colors.red,
                    ),
                    label: "Chat"),
                NavigationDestination(
                    icon: Icon(Icons.person_2_outlined),
                    selectedIcon: Icon(Icons.person_2, color: Colors.red),
                    label: "Profil")
              ],
            )));
  }
}
