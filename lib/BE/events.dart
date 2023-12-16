class Event
{
  final String eventname;
  final String time;
 Event({required this.eventname, required this.time});
}

Map<DateTime, List<Event>> eventslist = {};