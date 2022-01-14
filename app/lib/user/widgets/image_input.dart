import 'dart:io';

import 'package:caregiver_hub/shared/utils/io/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageInput extends FormField<String?> {
  ImageInput({
    FormFieldSetter<String?>? onSaved,
    FormFieldValidator<String?>? validator,
    bool autovalidate = false,
    String? initialValue,
    double? size = 0,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidate: autovalidate,
          builder: (FormFieldState<String?> state) {
            ImageProvider<Object> _buildImage() {
              final path = state.value;
              if (path == null) {
                return const AssetImage(
                  'assets/images/user_profile_placeholder.png',
                );
              } else if (File(path).existsSync()) {
                return FileImage(File(path));
              } else {
                return NetworkImage(path);
              }
            }

            Future<void> _findPicture() async {
              final newImage = await takePicture(galery: true);
              if (newImage != null) {
                state.didChange(newImage.path);
              }
            }

            Future<void> _takePicture() async {
              final newImage = await takePicture();
              if (newImage != null) {
                state.didChange(newImage.path);
              }
            }

            return Column(
              children: [
                Container(
                  width: size,
                  height: size,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(size!),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: _buildImage(),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _takePicture,
                      icon: const Icon(Icons.camera_alt),
                    ),
                    IconButton(
                      onPressed: _findPicture,
                      icon: const Icon(Icons.file_present),
                    ),
                  ],
                ),
                if (state.hasError)
                  Text(
                    state.errorText ?? '',
                    style: TextStyle(color: Theme.of(state.context).errorColor),
                  ),
              ],
            );
          },
        );
}
