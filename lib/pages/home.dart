import 'package:flutter/material.dart';
import 'package:ituapp/pages/profile_page.dart';
import 'package:ituapp/pages/spotDescription.dart';
import 'package:ituapp/pages/storage_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

double displayed_items = 1.0;

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Spot Center"),
              actions: [
                Slider(
                    min: 0.0,
                    max: 5.0,
                    value: displayed_items.toDouble(),
                    onChanged: (val) {
                      setState(() {
                        displayed_items = val;
                      });
                    })
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
                    icon: Icon(Icons.calendar_month_outlined),
                    selectedIcon: Icon(Icons.calendar_month_rounded),
                    label: "Kalendář"),
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
    final Storage storage = Storage();
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
          child: Center(
            child: FutureBuilder(
              future: storage.downloadUrl('spot1.jpg'),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Container(
                      width: 250,
                      height: 250,
                      child: Image.network(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      ));
                }
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
