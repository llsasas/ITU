import 'package:flutter/material.dart';
import 'package:ituapp/pages/profile_page.dart';
import 'package:ituapp/pages/spotDescription.dart';
import 'package:ituapp/pages/storage_handler.dart';
import 'package:ituapp/pages/custom_widgets.dart';
import 'package:ituapp/auth.dart';
import 'package:ituapp/pages/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

double displayed_items = 1.0;

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final User? user = Auth().currentUser;

  Future<void> signOut()async{
    await Auth().signOut();
  }
  Widget _signOutButt()
  {
    return ElevatedButton(onPressed: signOut,
     child: const Text('Sign out'));
  }
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Spot Center"),
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
                child: const Text('MAP'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: AddEventButton(),
                  ),
                  TableEvents()
                ],
              ),
              Chat(),
              ProfilePage(
                storage: storage,
              ),
            ][_currentIndex],
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              backgroundColor: Colors.redAccent.shade700,
              selectedIndex: _currentIndex,
              destinations: const <Widget>[
                NavigationDestination(icon: Icon(Icons.list), label: "Spoty"),
                NavigationDestination(
                    icon: Icon(Icons.map_outlined),
                    selectedIcon: Icon(Icons.map),
                    label: "Mapa"),
                NavigationDestination(
                    icon: Icon(Icons.calendar_month_outlined,color: Colors.white,),
                    selectedIcon: Icon(Icons.calendar_month_rounded,color: Colors.white,),
                    label: "Kalendář"),
                NavigationDestination(
                    icon: Icon(Icons.chat_outlined,color: Colors.white,),
                    selectedIcon: Icon(Icons.chat,color: Colors.white,),
                    label: "Chat"),
                NavigationDestination(
                    icon: Icon(Icons.person_2_outlined, color: Colors.white,),
                    selectedIcon: Icon(Icons.person_2,color: Colors.white,),
                    label: "Profil")
              ],
            )));
  }
}
