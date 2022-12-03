import 'dart:convert';

import 'package:pit02gp06/utils/i_http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements IHttpService {
  final SharedPreferences instance;
  SharedPreferencesService({required this.instance});

  @override
  Future get({required String url}) async => instance.getString(url);

  @override
  set({required String url, required data}) async =>
      instance.setString(url, jsonEncode(data));
}
