import 'package:pit02gp06/models/user_model.dart';
import 'package:pit02gp06/utils/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AuthRepository {
  Future<UserModel> getUser() async {
    UserModel user;
    final prefs = await SharedPreferences.getInstance();
    final codedUser = prefs.getString(SharedPreferencesKeys.user);
    if (codedUser == null) {
      user = UserModel(
          uid: const Uuid().v4(),
          name: 'guest_${DateTime.now().minute}_${DateTime.now().second}',
          balance: 0);
      setUser(user);
      return user;
    }
//    final jsonUser = jsonDecode(codedUser);
    user = UserModel.fromJson(codedUser);
    return user;
  }

  void setUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPreferencesKeys.user, user.toJson());
  }
}
