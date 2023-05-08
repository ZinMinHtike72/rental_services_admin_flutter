import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
class Storage_Services{
  static final storage = FlutterSecureStorage();
  static final loginDataKey = 'loginData';
  static setLoginData ({required data}) async{
    await storage.write(key: loginDataKey, value: json.encode(data));
  }

  static readLoginData() async{
   final data = await storage.read(key: loginDataKey);
   return data;
  }

  static deleteLoginData() async{
    await storage.delete(key: loginDataKey);
  }
}
