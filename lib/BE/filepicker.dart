import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ituapp/BE/storage_handler.dart';

class FilePickerButton extends StatelessWidget {
  const FilePickerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Center(
      child: ElevatedButton(
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