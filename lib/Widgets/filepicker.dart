import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ituapp/BE/storage_handler.dart';

String nametopass = '';
String pathtopass = '';
class FilePickerButton extends StatelessWidget {
  const FilePickerButton({Key? key});

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: () async {
          final result = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: ['png', 'jpg'],
          );

          if (result == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("No file selected"),
              ),
            );
            nametopass = '';
            return null;
          }
          nametopass = result.files.single.name;
          pathtopass = result.files.single.path!;
        },
        child:const Text(
          'Choose a picture',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
