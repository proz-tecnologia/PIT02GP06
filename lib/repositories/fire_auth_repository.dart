import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import 'api_response.dart';

class FireAuthRepository {
  const FireAuthRepository();

  final String _collection = "users";

  Future<UserModel?> userByUid(String uid) async {
    final user =
        await FirebaseFirestore.instance.collection(_collection).doc(uid).get();
    if (user.exists) {
      return UserModel.fromMap(user.data() as Map<String, dynamic>);
    }
    return null;
  }

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

  Future<ApiResponse?> register(
      UserModel userToRegister, String password) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userToRegister.email!,
        password: password,
      );

      final model = UserModel(
        uid: credential.user!.uid,
        name: userToRegister.name,
        phone: userToRegister.phone,
        email: userToRegister.email,
        balance: 0,
      );

      await FirebaseFirestore.instance
          .collection(_collection)
          .doc(credential.user?.uid)
          .set(model.toMap());

      return ApiResponse.result(result: model);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ApiResponse.result(
            error: "Senha fraca. Tente uma senha mais caprichada.");
      } else if (e.code == 'email-already-in-use') {
        return ApiResponse.result(error: "Esse e-mail já foi cadastrado.");
      }
    } catch (e) {
      return ApiResponse.result(
          error: "Houve um erro desconhecido. Tente depois.");
    }
    return null;
  }
}
