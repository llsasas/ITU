import 'package:flutter/material.dart';

class SpotDescription extends StatelessWidget {
  const SpotDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Spot Description"),centerTitle: true, backgroundColor: Colors.grey,),
    );
  }
}