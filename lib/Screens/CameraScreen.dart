import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:heyou/Screens/CameraView.dart';
import 'package:heyou/Screens/VideoView.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {



  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController cameraController;
  late Future<void> camerValue;
  bool isRecordin = false;
  bool flash = false;
  bool isCameraFront = false;
  double transform = 0;

  @override
  void initState() {
    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    camerValue = cameraController.initialize();
    setState(() {
      flash = false;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: SafeArea(
        child: Stack(

          children: [
            FutureBuilder(
                future: camerValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(cameraController);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            Positioned(

              bottom: 0.0,
              child: Container(

                color: Colors.transparent,
                padding: EdgeInsets.only(top: 5, bottom: 5),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,

                child: Column(children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: () {
                        setState(() {
                          flash = !flash;
                        });

                        flash
                            ? cameraController.setFlashMode(FlashMode.torch)
                            : cameraController.setFlashMode(FlashMode.off);
                      },
                          icon: Icon(
                            flash ? Icons.flash_on : Icons.flash_off, color: Theme
                              .of(context)
                              .accentColor, size: 28,)),
                      GestureDetector(
                          onLongPressUp: () async {
                            XFile videopath = await cameraController
                                .stopVideoRecording();
                            setState(() {
                              isRecordin = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        VideoView(
                                          path: videopath.path,
                                        )));
                          },
                          onLongPress: () async {
                            await cameraController.startVideoRecording();
                            setState(() {
                              isRecordin = true;
                            });
                          },
                          onTap: () {
                            if (!isRecordin) takePhoto(context);
                          },
                          child: isRecordin ? Icon(
                              Icons.radio_button_on, color: Colors.red) : Icon(
                            Icons.panorama_fish_eye, color: Theme
                              .of(context)
                              .accentColor, size: 70,)),
                      IconButton(

                          onPressed: () async {
                            setState(() {
                              isCameraFront = !isCameraFront;
                              transform = transform + pi * 90;
                            });
                            int cameraPos = isCameraFront ? 0 : 1;
                            cameraController = CameraController(
                                cameras[cameraPos], ResolutionPreset.high);
                            camerValue = cameraController.initialize();
                          },
                          icon: Transform.rotate(
                              angle: transform,
                              child: Icon(
                                Icons.flip_camera_ios_outlined, color: Theme
                                  .of(context)
                                  .accentColor, size: 28,))),


                    ],),
                  SizedBox(height: 4,),
                  Text("Hold for Video, tap for photo",
                    style: TextStyle(fontFamily: "Nunito", color: Theme
                        .of(context)
                        .accentColor), textAlign: TextAlign.center,),


                ],),

              ),
            ),

          ],
        ),
      ),
    );
  }

  void takePhoto(BuildContext context) async {

    XFile file = await cameraController.takePicture();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) =>
                CameraView(
                  path: file.path,
                )));
  }
}