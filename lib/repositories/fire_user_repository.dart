import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pit02gp06/models/user_model.dart';

class FireUserRepository {
  const FireUserRepository();

  final String _collection = "users";

  Future<UserModel?> byUid(String uid) async {
    final user =
        await FirebaseFirestore.instance.collection(_collection).doc(uid).get();
    if (user.exists) {
      return UserModel.fromMap(user.data() as Map<String, dynamic>);
    }
    return null;
  }
}
