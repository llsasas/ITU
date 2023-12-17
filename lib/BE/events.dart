/*
  Author: Samuel Čus - xcussa00
  Date: December 17, 2023
  Description: This is a Flutter source file for Class representing Events, BE
*/
class Event
{
  final String eventname;
  final String time;
 Event({required this.eventname, required this.time});
}

Map<DateTime, List<Event>> eventslist = {};