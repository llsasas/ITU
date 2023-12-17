import 'package:flutter/material.dart';
import 'package:ituapp/Widgets/spotform.dart';

class DropDownLevel extends StatefulWidget {
  const DropDownLevel({Key? key}) : super(key: key);

  @override
  State<DropDownLevel> createState() => _DropDownLevelState();
}

class _DropDownLevelState extends State<DropDownLevel> {
  String dropdownvalue = 'EASY';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: DropdownButton(
        value: dropdownvalue,
        icon: Icon(Icons.circle),
        style: TextStyle(color: Colors.black, fontSize: 16),
        items: const [
          DropdownMenuItem<String>(
            value: 'EASY',
            child: Text("EASY"),
          ),
          DropdownMenuItem<String>(
            value: 'INTERMEDIATE',
            child: Text("INTERMEDIATE"),
          ),
          DropdownMenuItem<String>(
            value: 'HARD',
            child: Text("HARD"),
          ),
        ],
        onChanged: (String? newvalue) {
          setState(() {
            dropdownvalue = newvalue!;
          });
          if (newvalue == "HARD") {
            dropvalue = 3;
          }
          if (newvalue == "EASY") {
            dropvalue = 1;
          }
          if (newvalue == "INTERMEDIATE") {
            dropvalue = 2;
          }
        },
      ),
    );
  }
}
