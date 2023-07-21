import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hello_world/scan_controller.dart';

class CameraShooter extends GetView<ScanController> {
  const CameraShooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Text(controller.get_label());
  }
}