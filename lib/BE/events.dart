class Event
{
  final String eventname;
  final String description;
 Event({required this.eventname, required this.description});
}

Map<DateTime, List<Event>> eventslist = {};