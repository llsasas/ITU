import 'package:flutter/material.dart';
import 'package:ituapp/BE/googlemaps.dart';
import 'package:ituapp/pages/profile_page.dart';
import 'package:ituapp/pages/storage_handler.dart';
import 'package:ituapp/pages/custom_widgets.dart';
import 'package:ituapp/auth.dart';
import 'package:ituapp/pages/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

double displayed_items = 10.0;

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final User? user = Auth().currentUser;

  Future<void> signOut()async{
    await Auth().signOut();
  }
  Widget _signOutButt()
  {
    return ElevatedButton(
      onPressed: signOut,
      style: ElevatedButton.styleFrom(
      backgroundColor: Colors.redAccent.shade700, // Změňte tuto barvu podle svých potřeb
  ),
     child: const Text('Sign out',
     style: TextStyle(color: Colors.white),));
  }
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Spot Center",
               style: TextStyle(
                fontWeight: FontWeight.normal, 
                fontSize: 40.0,
                color: Colors.white, 
              ),),
              actions: [_signOutButt(),
                /*
                Slider(
                    min: 0.0,
                    max: 5.0,
                    value: displayed_items.toDouble(),
                    onChanged: (val) {
                      setState(() {
                        displayed_items = val;
                      });
                    })*/

              ],
              centerTitle: true,
              backgroundColor: Colors.redAccent.shade700,
            ),
            body: <Widget>[
              Container(
                  color: Colors.grey.shade100,
                  padding: const EdgeInsets.all(30),
                  child: ListView.builder(
                      itemCount: displayed_items.toInt(),
                      itemBuilder: (BuildContext context, int index) {
                        return const SpotCard();
                      })),
              Container(
                color: Colors.blue,
                alignment: Alignment.center,
                child: MapSample(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: AddEventButton(),
                  ),
                  TableEvents()
                ],
              ),
              Chat(),
              ProfilePage(
              ),
            ][_currentIndex],
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                setState(() {
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
                    selectedIcon: Icon(Icons.map,color: Colors.red),
                    label: "Mapa"),
                NavigationDestination(
                    icon: Icon(Icons.calendar_month_outlined,),
                    selectedIcon: Icon(Icons.calendar_month_rounded,color: Colors.red,),
                    label: "Kalendář"),
                NavigationDestination(
                    icon: Icon(Icons.chat_outlined,),
                    selectedIcon: Icon(Icons.chat,color: Colors.red,),
                    label: "Chat"),
                NavigationDestination(
                    icon: Icon(Icons.person_2_outlined),
                    selectedIcon: Icon(Icons.person_2,color: Colors.red),
                    label: "Profil")
              ],
            )));
  }
}
