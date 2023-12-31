import 'package:flutter/material.dart';
import 'package:ituapp/BE/events.dart';
import 'package:ituapp/Widgets/time_picker.dart';
import 'package:table_calendar/table_calendar.dart';

class TableEvents extends StatefulWidget {
  @override
  TableEventsState createState() => TableEventsState();
}

class TableEventsState extends State<TableEvents> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final TextEditingController _controllername = TextEditingController();
  //final TextEditingController _controllerdescription = TextEditingController();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return eventslist[day] ?? [];
  }

  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; //
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return Container(
      width: 230,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: title),
      ),
    );
  }

  Widget _button() {
    return FloatingActionButton(
      onPressed: () {
        // Zde zavoláte funkci pro otevření nového okna
        _openNewWindow(context);
      },
      elevation: 2.0,
      backgroundColor: Colors.red,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add_sharp,
        size: 35.0,
        color: Colors.white,
      ),
    );
  }

  void _openNewWindow(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          //title: const Text("Add event"),
          contentPadding: const EdgeInsets.all(50.0),
          children: <Widget>[
            _entryField('Event', _controllername),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Select time",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ),
            const SizedBox(height: 10),
            const WidgetTimePicker(),
            const SizedBox(height: 30),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    final List<Event> eventsForDay =
                        eventslist[_selectedDay!] ?? [];

                    eventsForDay.add(Event(
                      eventname: _controllername.text,
                      time: chosen_time.format(context),
                    ));

                    eventslist[_selectedDay!] = eventsForDay;

                    Navigator.of(context).pop();
                    _selectedEvents.value = _getEventsForDay(_selectedDay!);
                  },
                  child: const Text(
                    "Add event",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _button(),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: DateTime.utc(2018, 1, 1),
            lastDay: DateTime.utc(2035, 12, 12),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            headerStyle:
                HeaderStyle(formatButtonVisible: false, titleCentered: true),
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            onTap: () => print(""),
                            title: Text(
                                'Event: ${value[index].eventname}     Time:${value[index].time}'),
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
