import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:caregiver_hub/shared/exceptions/service_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

Future<dynamic> handleFirebaseExceptions(Function fn) async {
  try {
    return await fn();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-email') {
      throw ServiceException('O e-mail não é válido.');
    }
    if (e.code == 'user-disabled') {
      throw ServiceException('O usuário está desabilitado.');
    }
    if (e.code == 'user-not-found') {
      throw ServiceException('O e-mail não pertence a nenhum usuário.');
    }
    if (e.code == 'wrong-password') {
      throw ServiceException('A senha digitada está incorreta.');
    }
    if (e.code == 'email-already-in-use') {
      throw ServiceException('O e-mail já está em uso.');
    }
    if (e.code == 'invalid-email') {
      throw ServiceException('O e-mail é inválido.');
    }
    if (e.code == 'operation-not-allowed') {
      throw ServiceException('A operação não é permitida.');
    }
    if (e.code == 'weak-password') {
      throw ServiceException('A senha é muito fraca.');
    }
    throw ServiceException('Ocorreu um erro na comunicação com o servidor.');
  } on ServiceException catch (_) {
    rethrow;
  } on Exception catch (_) {
    throw ServiceException('Ocorreu um erro na comunicação com o servidor.');
  }
}

Future<dynamic> handleHttpExceptions(Function fn) async {
  try {
    return fn();
  } on ServiceException catch (e) {
    rethrow;
  } on Exception catch (e) {
    throw ServiceException(e.toString());
  }
}
