import 'package:gellarytask/common/api_endpoints.dart';
import 'package:gellarytask/common/shared_preferences.dart';

import '../api.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';

class Gallery{
  final Map<String, dynamic> result = {};
  List<String> gallery=[];

  Future<Map<String, dynamic>> getGallery() async {
    Map<String, dynamic> data = await Api().get(endpoint: 'my-gallery',);
    if (data['status'] == 'success') {
      for(int i =0;i<data['data']['images'].length;i++){
        gallery.add(data['data']['images'][i]);
      }

      result['status'] = 'success';
      result['gallery'] = gallery;
      return result;
    } else {
      result['status'] = 'error';
      result['message'] = data['message']!;
      return result;
    }
  }

  Future<String> uploadImage(File image) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://flutter.prominaagency.com/api/upload'),
    );
    final token = await getKeyAndStringValueFromSharedPreferences('token');
    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    request.files.add(
      await http.MultipartFile.fromPath(
        'img',
        image.path,
        filename: basename(image.path),
      ),
    );

    var response = await request.send();
    if (response.statusCode == 200) {
      return 'Image uploaded successfully';
    } else {
      return 'Image upload failed';
    }
  }

  Map<String,dynamic> errorFields = {};

  Future<Map<String, dynamic>> sendGallery(Map<String,String?> bodyData) async {

    Map<String,dynamic> data = await Api().post(endpoint: "upload",body:bodyData);
    print(bodyData);
    print(data);
    if (data['status']=='success') {
      result['status'] = 'success';
      result['message'] = data['message']!;
      return result;
    }else{
      if (data.containsKey('errorFields')){
        errorFields = data['errorFields'];
      }

      result['errorFields'] = errorFields;
      result['status'] = 'error';
      result['message'] = data['message']!;
      return result;
    }
  }
}