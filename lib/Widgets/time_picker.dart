/*
  Author: Samuel Čus - xcussa00
  Date: December 17, 2023
  Description: This is a Flutter source file representing timepicker widget used in calendar implementation
*/

import 'package:flutter/material.dart';

  TimeOfDay chosen_time = TimeOfDay.now();

class WidgetTimePicker extends StatefulWidget
{
  const WidgetTimePicker({Key? key}) : super(key: key);

  @override
  WidgetTimePickerState createState(){
    return WidgetTimePickerState();
  }
}

class WidgetTimePickerState extends State<WidgetTimePicker>
{
  @override
  Widget build(BuildContext context)
  {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: ()async{
            final TimeOfDay? timeOfDay = await showTimePicker(context: context,
             initialTime: chosen_time,
             initialEntryMode: TimePickerEntryMode.dial,
             );
             if(timeOfDay!= null)
             {
              setState(()
              {
                chosen_time = timeOfDay;
              }
              );
             }
          },
           child: Text("${chosen_time.hour}:${chosen_time.minute == 0 ? '00' : chosen_time.minute < 10 ? '0${chosen_time.minute}' : chosen_time.minute}  ${chosen_time.period.toString().split('.').last}",
           style: TextStyle(
            fontSize: 14,
            color: Colors.black,
           ),),
           )
        ],
      ),
    );
  }
}