import 'package:flutter/material.dart';
import 'package:gellarytask/screens/home.dart';
import '../../API/api_services/login.dart';
import '../../providers/global_provider.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';
import 'widgets/input_form_field.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool indicator = false;
  bool obscure =true;


  Map<String, String> dataLogin = {
    'email': '',
    'password': '',
  };


  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/login.png', // Replace with your image asset path
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30,left: 30,top: 20),
            child: Form(
              key: formKey,
              child: AutofillGroup(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('My \n Gellary',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff4A4A4A),
                          fontSize: 50,
                          fontWeight: FontWeight.bold
                      ),),
                    const SizedBox(height: 20.0),
                    Container(
                      width: 320,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255,255,255,0.4 ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.only(left: 15,right: 15,top: 40,bottom: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Log in',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff4A4A4A),
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                            ),),
                          const SizedBox(height: 20.0),
                          FormInputField(
                            controller: _emailController,
                            autoFillHints: const <String>[
                              AutofillHints.telephoneNumber
                            ],
                            keyboardType: TextInputType.emailAddress,
                            onChange: (value) {
                              dataLogin['email'] = value;
                            },
                            prefixText: "Email",
                          ),
                          const SizedBox(height: 16.0),
                          FormInputField(
                            controller: _passwordController,
                            autoFillHints: const <String>[
                              AutofillHints.password
                            ],
                            obscure: obscure,
                            hintText: '',
                            onChange: (value) {
                              dataLogin['password'] = value;
                            },
                            icon: IconButton(
                              onPressed: (){
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              icon: Icon(obscure?Icons.visibility:Icons.visibility_off,color: const Color(0xff1A9BCA),),
                            ),
                            prefixText: 'password',
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff7BB3FF),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.only(left: 8,right: 8),
                              child: TextButton(
                                onPressed: ()async{
                                  OverlayLoadingProgress.start(context, barrierDismissible: true);
                                  if(formKey.currentState!.validate()){
                                    Map<String, dynamic> myData = await Login().login(dataLogin);
                                    if(myData['status']=='success'){
                                      if(context.mounted){
                                        final userData = myData['user'];
                                        final globalProvider = Provider.of<GlobalProvider>(context,listen: false);
                                        globalProvider.setUserData(userData);
                                        print(userData);
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                                      }
                                    }else{
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(myData['message']!),
                                          ),
                                        );
                                      }
                                    }
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Fill required data"),
                                      ),
                                    );
                                  }
                                  OverlayLoadingProgress.stop();
                                },
                                child: const SizedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.center,
                                        'Submit',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
