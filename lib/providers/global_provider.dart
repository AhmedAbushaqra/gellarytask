import 'package:flutter/material.dart';

import '../models/user_model.dart';
class GlobalProvider extends ChangeNotifier{
  UserModel? _userData;
  UserModel? get userData => _userData;

  String? _unseenNotificationsCount = "0";
  String? get unseenNotificationsCount => _unseenNotificationsCount;

  void setUserData(UserModel newUser){
    _userData = newUser;
    notifyListeners();
  }

  void clearUserData(){
    _userData = null;
    notifyListeners();
  }

  void setUnseenNotificationsCount(String newUnseenNotificationsCount){
    _unseenNotificationsCount = newUnseenNotificationsCount;
    notifyListeners();
  }

  void clearUnseenNotificationsCount(){
    _unseenNotificationsCount = "0";
    notifyListeners();
  }
}