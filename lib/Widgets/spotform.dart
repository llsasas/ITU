import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final TextEditingController _controllername = TextEditingController();
  final TextEditingController _controlleraddress = TextEditingController();
  final TextEditingController _controllerdescription = TextEditingController();

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  void add()
  {
    print('hello');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add spot'),
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _entryField('Name', _controllername),
            _entryField('Adress', _controlleraddress),
            _entryField('Description', _controllerdescription),
          ],
        ),
      ),
    );
  }
}
