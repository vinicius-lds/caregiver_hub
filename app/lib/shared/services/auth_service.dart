import 'package:caregiver_hub/shared/exceptions/service_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

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

  String? currentUserId() {
    return _auth.currentUser?.uid;
  }

  Future<dynamic> _safe(Function fn) async {
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
      throw ServiceException('Ocorreu um erro na comunicação com o servidor.');
    } on ServiceException catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw ServiceException('Ocorreu um erro na comunicação com o servidor.');
    }
  }
}
