import 'package:firebase_auth/firebase_auth.dart';

import 'api_response.dart';

class FireAuthRepository {
  const FireAuthRepository();

  Future<ApiResponse?> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ApiResponse.result(result: credential.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ApiResponse.result(error: "E-mail não cadastrado");
      } else if (e.code == 'wrong-password') {
        return ApiResponse.result(error: "Senha errada");
      }
    } catch (e) {
      return ApiResponse.result(error: "Erro desconhecido ($e)");
    }
    return null;
  }
}
