import 'package:caregiver_hub/shared/utils/io.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<void> logout() async {
    await handleFirebaseExceptions(() async {
      await _auth.signOut();
    });
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await handleFirebaseExceptions(() {
      return _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    });
  }
}
