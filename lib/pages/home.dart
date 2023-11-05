import 'package:flutter/material.dart';
import 'package:ituapp/pages/spotDescription.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Spot Center"),centerTitle: true, backgroundColor: Colors.grey,),
      body: Container(
        color: Colors.grey.shade100,
        padding: EdgeInsets.all(30),
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(10),
          children: <Widget>[
            SpotCard(),
            SpotCard(),
            SpotCard(),
            SpotCard(),
            SpotCard()
          ]
          ),
      ),
      bottomNavigationBar: NavigationBar(
      backgroundColor: Colors.grey,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.list), 
          label: "Spoty"
          ),
        NavigationDestination(
          icon: Icon(Icons.map_outlined),
          selectedIcon: Icon(Icons.map), 
          label: "Mapa"
          ),
        NavigationDestination(
          icon: Icon(Icons.person_2_outlined),
          selectedIcon: Icon(Icons.person_2)
          , label: "Profil"
          )
      ],
      )
    );
  }
}

class SpotCard extends StatelessWidget {
  const SpotCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SpotDescription())
          );
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