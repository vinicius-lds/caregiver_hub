import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

Future<File?> takePicture({bool galery = false}) async {
  final picker = ImagePicker();
  final source = galery ? ImageSource.gallery : ImageSource.camera;
  final pickedImage = await picker.pickImage(source: source);
  if (pickedImage != null) {
    final imageFile = File(pickedImage.path);
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final savedImage = await imageFile.copy(
      '${appDir.path}/${path.basename(imageFile.path)}',
    );
    return savedImage;
  }
  return null;
}
