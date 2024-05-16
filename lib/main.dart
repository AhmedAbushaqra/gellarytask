import 'package:flutter/material.dart';
import 'package:gellarytask/API/api_services/login.dart';
import 'package:gellarytask/common/shared_preferences.dart';
import 'package:gellarytask/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/global_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => GlobalProvider(),
          )
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        )
    );
  }
}
