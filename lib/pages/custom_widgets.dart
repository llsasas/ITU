import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ituapp/pages/storage_handler.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:ituapp/pages/spotDescription.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

final _formkey = GlobalKey<FormState>();

class FilePickerButton extends StatelessWidget
{
  @override
 Widget build(BuildContext context) {
  final Storage storage = Storage();
  return Center(
    child: ElevatedButton(
      onPressed:() async {
        final result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['png', 'jpg'],
        );

        if (result == null)
        {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No file selected"),   
            ),
          );
          return null;
        }

        final path = result.files.single.path!;
        final filename = result.files.single.name;
        storage.uploadFile(path, filename);
    }, 
    child: const Text('Choose a picture'),
    ),
    
  );
}
}

class FormWidget extends StatelessWidget
{
  const FormWidget({Key? key}) : super (key: key);
  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.place),
                labelText: "Název spotu",
              ),
              validator: (value) {
                if(value == null || value.isEmpty)
                {
                  return "Invalid input typed";
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: ()
              {
                if(_formkey.currentState!.validate()) {

                }
              }, child: const Text("Přidat spot")
              ),
          ],
        ),
       ),
    );
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


// TODO ADD functionality to OnPressed, new window should be opened 
class AddSpotButton extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return const RawMaterialButton(
      onPressed: null,
      elevation: 2.0,
      fillColor: Colors.white,
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      child: Icon(
        Icons.add_rounded, 
        size: 35.0,
        ),
      );
  }
}


//Add functionality to onpressed
class AddEventButton extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return const RawMaterialButton(
      onPressed: null,
      elevation: 2.0,
      fillColor: Colors.white,
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      child:  Icon(
        Icons.add_sharp, 
          size: 35.00,
          color: Colors.red,
        ),
      );
  }
}

class TableEvents extends StatefulWidget {
  @override
  TableEventsState createState() => TableEventsState();
}

class TableEventsState extends State<TableEvents>
{
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
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



  //TODO potreba doimplementovat napojeni na BE
  
  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return [];
  }

  List<DateTime> daysInRange(DateTime first, DateTime last) 
  {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
  }

  //TODO nefunkcni, potreba dodelat napojeni na BE

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
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
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay)
   {
    setState(() 
    {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) 
    {
      _selectedEvents.value = _getEventsForRange(start, end);
    }
    else if (start != null) 
    {
      _selectedEvents.value = _getEventsForDay(start);
    }
    else if (end != null) 
    {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }
  
  @override
  Widget build(BuildContext context) 
  {
    return TableCalendar<Event>(
            firstDay: DateTime.utc(2018,1,1),
            lastDay: DateTime.utc(2035,12,12),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: 
            const CalendarStyle(
              // Use `CalendarStyle` to customize the UI
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
          );
  }


}