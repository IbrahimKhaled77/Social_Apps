

// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class Preference{

  static SharedPreferences? preferences;


  static init() async{
    preferences=  await  SharedPreferences.getInstance();

  }


  static Future<bool> setData({
    required String key,
    required dynamic value,

  }) async {

    return await preferences!.setBool(key, value);


  }

//same setData all//set data
  static Future<bool>saveData({
    required String key,
    required dynamic value,

  }) async {
    if(value is String) {
      return await preferences!.setString(key, value);
    } else if(value is int) {
      return await preferences!.setInt(key, value);
    } else if(value is bool) {
      return await preferences!.setBool(key, value);
    } else {
      return await preferences!.setDouble(key, value);
    }



  }

  static dynamic getData(
      {required String key,}

      ){

    return  preferences!.get(key);


  }


  static Future<bool> removeData({
    required String key,
  })async{
    return await preferences!.remove(key);

  }




}