import 'package:dio/dio.dart';
import 'dart:convert';
class Api_Services{
   static Map? _loginData = {};

   static setLoginData(Map? data){
    _loginData = data;
   }
  static Map _headers ={};
  static Map _queryParameter ={};
  static BaseOptions _options = BaseOptions(
      baseUrl: Constant_Api.baseUrl,
      // connectTimeout: const Duration(seconds: 10),
      );
  static var _dio = Dio(_options);

  static void _createOptions(Map? queryParameter,String? baseUrl,Map? headers) {
    if(_loginData != null){
      _dio.options.queryParameters = { 'admin_id':_loginData?["_id"]};
      _dio.options.headers = { 'authorization' : 'Bearer ${_loginData?['auth_token']}'};
    }
    if(baseUrl != null){
      _dio.options.baseUrl = Constant_Api.baseUrl;
    }
    if(queryParameter != null){
      _dio.options.queryParameters = {
        ... _dio.options.queryParameters,
        ...queryParameter,
      };
    }
    if(headers != null){
      _dio.options.headers = {
        ... _dio.options.headers,
        ...headers,
      };
    }
  }
  static Future getMethod(
      {Map? queryParameter, String? baseUrl, Map? headers,required String path}) async{
     _createOptions(queryParameter, baseUrl, headers);
      final responseData = await _dio.get(path);
      final jsonData = responseData.data;
      return jsonData;
  }

  static Future postMethod(
      {Map? queryParameter, String? baseUrl, Map? headers,required Map data,required String path}) async{
     _createOptions(queryParameter, baseUrl, headers);
     final responseData = await _dio.post(path,data: data);
     final jsonData = responseData.data;
     return jsonData;
  }

  static Future deleteMethod({Map? queryParameter, String? baseUrl, Map? headers,required String path}) async{
    _createOptions(queryParameter, baseUrl, headers);
    final responseData = await _dio.delete(path);
    final jsonData = responseData.data;
    return jsonData;
  }

  static Future putMethod( {Map? queryParameter, String? baseUrl, Map? headers,required Map data,required String path}) async{
    _createOptions(queryParameter, baseUrl, headers);
    _dio.options.queryParameters = {
      ... _dio.options.queryParameters,
      "_method":"PUT"
    };
    final responseData = await _dio.post(path,data: data);
    final jsonData = responseData.data;
    return jsonData;
  }
}

class Constant_Api{
  static String baseUrl= "http://192.168.100.8:8003/api/admin/";
  // static String baseUrl= "http://192.168.2.123:8003/api/admin/";
  static String registerApi ="register";
  static String logoutApi = "logout";
  static String loginApi = 'login';
  static String brandsApi = 'brands';
  static String profile = 'profile';
  static String changePassword = 'change/password';
  static String category = 'categories';
  static String business = 'businesses';
  static String count = 'counts';
  static String product = 'products';
  static String productVendor = 'vendor-lists';
  static String activeVendorList = 'active/vendor-lists';
  static String inActiveVendorList = 'inactive/vendor-lists';
  static String activeVendorProcess = 'active/vendor/process';
  static String inactiveVendorProcess = 'inactive/vendor/process';
  static String rentLists = 'rent-lists';
}

