
import 'package:get/get.dart';
import 'package:hello_world/scan_controller.dart';

class GlobalBindings extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<ScanController>(() => ScanController());
  }
}