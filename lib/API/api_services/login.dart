import '../api.dart';
import '../../common/shared_preferences.dart';
import '../../models/user_model.dart';

class Login{
  final Map<String, dynamic> result = {};
  late UserModel userData;

  Future<Map<String, dynamic>> login(Map<String, String?> bodyData) async {
    Map<String, dynamic> data = await Api().post(endpoint: 'auth/login', body: bodyData,);
    print(data);
    if (data.containsKey('user')) {
      saveKeyAndStringValueToSharedPreferences('token', data['token'].toString());
      print(prefs.getString('token'));
      userData = UserModel.fromJson(data['user']);

      result['status'] = 'success';
      result['user'] = userData;
      return result;
    } else {
      result['status'] = 'error';
      result['message'] = data['message']!;
      return result;
    }
  }
}