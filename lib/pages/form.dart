import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ituapp/pages/storage_handler.dart';

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