import 'package:flutter/material.dart';
import 'package:heyou/Screens/CameraScreen.dart';
class CamerPage extends StatefulWidget {
  const CamerPage({Key? key}) : super(key: key);

  @override
  State<CamerPage> createState() => _CamerPageState();
}

class _CamerPageState extends State<CamerPage> {
  @override
  Widget build(BuildContext context) {
    return CameraScreen();
  }
}
