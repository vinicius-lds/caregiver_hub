import 'dart:io';

import 'package:caregiver_hub/shared/exceptions/service_exception.dart';
import 'package:caregiver_hub/user/models/user_form_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Stream<UserFormData> fetchUserFormData(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .get()
        .asStream()
        .map((snapshot) {
      final docs = snapshot.data() as Map<String, dynamic>;
      return UserFormData(
        imageURL: docs['imageURL'],
        name: docs['fullName'],
        cpf: docs['cpf'],
        phone: docs['phone'],
        email: docs['email'],
      );
    });
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _safe(() {
      return _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    });
  }

  Future<void> updateUser({
    required String? imagePath,
    required String fullName,
    required String cpf,
    required String phone,
    required String email,
    required String? password,
  }) async {
    return await _safe(() async {
      if (_auth.currentUser == null) {
        throw ServiceException(
          'É necessário estar logado para alterar os dados do usuário.',
        );
      }

      if (password != null && password.trim() != '') {
        _auth.currentUser!.updatePassword(password);
      }

      String? imageURL = imagePath == null || imagePath.trim() == ''
          ? null
          : await uploadImage(_auth.currentUser!.uid, imagePath);

      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        'fullName': fullName,
        'cpf': cpf,
        'phone': phone,
        'email': email,
        'imageURL': imageURL,
      });
    });
  }

  Future<UserCredential> createUser({
    required String? imagePath,
    required String fullName,
    required String cpf,
    required String phone,
    required String email,
    required String password,
  }) async {
    return await _safe(() async {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? imageURL = imagePath == null || imagePath.trim() == ''
          ? null
          : await uploadImage(userCredential.user!.uid, imagePath);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'cpf': cpf,
        'phone': phone,
        'email': email,
        'imageURL': imageURL,
      });

      return userCredential;
    });
  }

  Future<String> uploadImage(String userId, String imagePath) async {
    final ref = _storage.ref().child('userImage').child(userId + '.jpg');
    return await (await ref.putFile(File(imagePath))).ref.getDownloadURL();
  }

  Future<dynamic> _safe(Function fn) async {
    try {
      return await fn();
    } on FirebaseAuthException catch (e) {
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
      throw ServiceException('Ocorreu um erro na comunicação com o servidor.');
    } on ServiceException catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw ServiceException('Ocorreu um erro na comunicação com o servidor.');
    }
  }
}
