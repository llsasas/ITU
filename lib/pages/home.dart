import 'package:flutter/material.dart';
import 'package:ituapp/pages/spotDescription.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Spot Center"),
              centerTitle: true,
              backgroundColor: Colors.grey,
            ),
            body: <Widget>[
              Container(
                color: Colors.grey.shade100,
                padding: const EdgeInsets.all(30),
                child: ListView(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(10),
                    children: const <Widget>[
                      SpotCard(),
                      SpotCard(),
                      SpotCard(),
                      SpotCard(),
                      SpotCard()
                    ]),
              ),
              Container(
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text('MAP'),
              ),
              Container(
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text('PROFILE'),
              ),
            ][_currentIndex],
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              backgroundColor: Colors.grey,
              selectedIndex: _currentIndex,
              destinations: const <Widget>[
                NavigationDestination(icon: Icon(Icons.list), label: "Spoty"),
                NavigationDestination(
                    icon: Icon(Icons.map_outlined),
                    selectedIcon: Icon(Icons.map),
                    label: "Mapa"),
                NavigationDestination(
                    icon: Icon(Icons.person_2_outlined),
                    selectedIcon: Icon(Icons.person_2),
                    label: "Profil")
              ],
            )));
  }
}

class SpotCard extends StatelessWidget {
  const SpotCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SpotDescription()));
        },
        child: Container(
          width: 350,
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 30),
          color: const Color.fromARGB(255, 157, 161, 165),
          child: Center(child: const Text("hello")),
        ),
      ),
    );
  }
}
