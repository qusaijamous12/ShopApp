import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper{
static SharedPreferences ?sharedPreferences;
static Future<void> init()async{
   sharedPreferences=await SharedPreferences.getInstance();
}

static Future<bool> SaveData({
  required dynamic data,
  required String key
})async{
  if(data is double){
    return await sharedPreferences!.setDouble(
        key,
        data);
  }
  else if(data is String){
    return await sharedPreferences!.setString(key, data);
  }
  else if(data is int){
    return await sharedPreferences!.setInt(key, data);
  }
  else{
    return await sharedPreferences!.setBool(key, data);
  }

}

static dynamic GetData({
  required String key,
}){
  return sharedPreferences!.get(key);


}

static Future<bool> DeleteData({
  required String key
})async{
  return await sharedPreferences!.remove(key);
}

static Future<bool> saveString(
{
  required String key,
  required String data
})async{
  return await sharedPreferences!.setString(key, data);


}

static String? getData(String key){
  return sharedPreferences!.getString(key);
}

}