import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../common/shared_preferences.dart';
import '../common/api_endpoints.dart';
class Api {

  Future<dynamic> post({
    required String endpoint,
    @required dynamic body
  }) async {
    Map<String, String> headers = {};
    final token = await getKeyAndStringValueFromSharedPreferences('token');
    headers.addAll({
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',
    'Connection': 'keep-alive',});
    http.Response response = await http.post(Uri.parse(baseURL + endpoint), body: body, headers: headers);

    Map<String, dynamic> data = {};

    if (response.statusCode == 200) {
      try{
        data = jsonDecode(response.body);
      }catch(err){
        data['status'] = 'error';
        data['message'] = 'server error';
      }
    } else {
      //throw Exception('There is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
      data['status'] = 'error';
      data['message'] = 'server error response';
    }

    return data;
  }

  Future<dynamic> get({
    required String endpoint,
  }) async {
    Map<String, String> headers = {};
    final token = await getKeyAndStringValueFromSharedPreferences('token');
    headers.addAll({'Authorization': 'Bearer $token'});
    http.Response response = await http.get(Uri.parse(baseURL + endpoint), headers: headers);

    Map<String, dynamic> data = {};

    if (response.statusCode == 200) {
      try{
        data = jsonDecode(response.body);
      }catch(err){
        data['status'] = 'error';
        data['message'] = 'server error';
      }
    } else {
      //throw Exception('There is a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
      data['status'] = 'error';
      data['message'] = 'server error response';
    }

    return data;
  }
}
