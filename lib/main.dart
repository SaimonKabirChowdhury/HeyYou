import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:heyou/NewScreen/LandingScreen.dart';
import 'package:heyou/Screens/CameraScreen.dart';
import 'package:heyou/Screens/HomeScreen.dart';
import 'package:heyou/Screens/LoginScreen.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   cameras = await availableCameras();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0XFFBEC8EB),
        accentColor: const Color(0XFFDAE2FE),
      ),
      home:  LandingScreen(),
    );
  }
}

