import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_world/camera/camera_shooter.dart';
import 'package:hello_world/camera/camera_viewer.dart';
import 'package:hello_world/scan_controller.dart';

class CameraScreen extends StatelessWidget{
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Stack(
      alignment: Alignment.center,
      children: const [CameraViewer(),
      CameraShooter()
      ],
   );
  }
}