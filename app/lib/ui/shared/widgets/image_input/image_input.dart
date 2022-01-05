import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function? onSelectImage;

  const ImageInput({
    Key? key,
    this.onSelectImage,
  }) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 600,
    );
    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      setState(() => _storedImage = imageFile);
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final savedImage = await imageFile.copy(
        '${appDir.path}/${path.basename(imageFile.path)}',
      );
      widget.onSelectImage!(savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage == null
              ? const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  _storedImage as File,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
          alignment: Alignment.center,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera),
            label: Text(
              'Take Picture',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
