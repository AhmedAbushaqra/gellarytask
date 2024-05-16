import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gellarytask/API/api_services/gallery.dart';
import 'package:gellarytask/common/shared_preferences.dart';
import 'package:gellarytask/models/user_model.dart';
import 'package:gellarytask/providers/global_provider.dart';
import 'package:gellarytask/screens/login/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _showImagePickerDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(255,255,255,0.4 ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  width: 160,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffEFD8F9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.only(left: 8,right: 8),
                  child: TextButton(
                    onPressed: ()async{
                      _pickImageAndUpload(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                    child: const SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            'Gellary',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff4A4A4A)
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              const SizedBox(height: 15,),
              Container(
                  width: 160,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xffEBF6FF),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.only(left: 8,right: 8),
                  child: TextButton(
                    onPressed: ()async{
                      _pickImageAndUpload(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                    child: const SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            'Camera',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff4A4A4A)
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImageAndUpload(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
        OverlayLoadingProgress.start(context, barrierDismissible: true);
        _image = File(pickedFile.path);
         String response = await Gallery().uploadImage(_image!);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response),
            ),
          );
        }
          OverlayLoadingProgress.stop();

        setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel userData = Provider.of<GlobalProvider>(context).userData!;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/home.png', // Replace with your image asset path
            fit: BoxFit.cover,
          ),

          Padding(
            padding: const EdgeInsets.only(right: 30,left: 20,top: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Welcome \n ${userData.name}',
                      style: const TextStyle(
                          color: Color(0xff4A4A4A),
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        "https://fastly.picsum.photos/id/469/300/600.jpg?hmac=fPbjF7k1YeQPPD3wwSG3mnAUHrygjPfFjLHsHUT3z-A",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 145,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255,255,255,0.57 ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.only(left: 8,right: 8),
                        child: TextButton(
                          onPressed: ()async{
                            await prefs.clear();
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
                          },
                          child: const SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  'Log out',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff4A4A4A)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),


                    Container(
                        width: 145,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255,255,255,0.57 ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.only(left: 8,right: 8),
                        child: TextButton(
                          onPressed: _showImagePickerDialog,
                          child: const SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  'uplaod',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff4A4A4A)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                ),

                const SizedBox(height: 15,),

                Expanded(
                  child:  FutureBuilder(
                    future: Gallery().getGallery(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No data found'));
                      } else {
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.0,
                            crossAxisSpacing: 15.0,
                            mainAxisSpacing: 25.0,
                          ),
                          itemCount: snapshot.data!['gallery'].length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(
                                snapshot.data!['gallery'][index],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
