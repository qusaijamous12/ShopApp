import 'package:dio/dio.dart';

class DioHelper{
  static Dio ?dio;
  static init(){
   dio=Dio(
     BaseOptions(
       receiveDataWhenStatusError: true,
       baseUrl: 'https://student.valuxapps.com/api/'
     )
   );
  }
  static Future<Response> PostData({
    required String path,
    Map<String,dynamic> ?query,
    required dynamic data,
    String ?lang='en',
    String ?token,
}) async{
    dio!.options!.headers={
      'lang':lang,
      'Content-Type':'application/json',
      'Authorization':token
    };

    return await dio!.post(
      path,
      queryParameters: query,
      data: data,
    );

  }


  static Future<Response> GetData({
    required String path,
    String ?lang='en',
    String ?token,
})async{
    dio!.options.headers={
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json'

    };
    return await  dio!.get(
      path,

    );
  }


  static Future<Response> UpdateData({
    required String path,
    required dynamic data,
    String lang='en',
    required String token
}) async {
    dio!.options.headers={
      "lang":lang,
      "Content-Type":"application/json",
      "Authorization":token
    };

    return await dio!.put(
      path,
      data: data,


    );
  }

}