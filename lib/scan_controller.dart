import 'dart:typed_data';
//import 'package:tflite/tflite.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

class ScanController extends GetxController{

  final RxBool _isInitialized = RxBool(false);
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  late CameraImage _cameraImage;
  RxList<Uint8List> _imageList = RxList([]);
  int _imgCount = 0;

  List<Uint8List> get imageList => _imageList;
  bool get isInitialized => _isInitialized.value;
  CameraController get cameraController => _cameraController;

  var label = "";


  @override
  void dispose() {
    _isInitialized.value = false;
    _cameraController.dispose();
    Tflite.close();
    super.dispose();
  }

  get_label(){
    return label;
  }

  Future<void> _initTFlite() async {
    String? res = await Tflite.loadModel(   
      model: "assets/mnist.tflite",
      labels: "assets/mnist.txt",
      numThreads: 1, // defaults to 1
      isAsset: true, // defaults to true, set to false to load resources outside assets
      useGpuDelegate: false // defaults to false, set to true to use GPU delegate
    );

  }

  Future<void> _initCamera() async{
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.max, imageFormatGroup: ImageFormatGroup.bgra8888);
    await _cameraController.initialize().then((_) {
    _isInitialized.value = true;

    _cameraController.startImageStream((image) {
      _imgCount = _imgCount + 1;
      if(_imgCount % 30 == 0){
        _imgCount = 0;
        _digitRecognition(image);
      }
    });
  
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });

  }

  @override
  void onInit() {
    super.onInit();
    _initCamera();
    _initTFlite();
  }

  Future<void>_digitRecognition(CameraImage cameraImage) async {
    var recognitions = await Tflite.runModelOnFrame(
      bytesList: cameraImage.planes.map((plane) {return plane.bytes;}).toList(),// required
      imageHeight: cameraImage.height,
      imageWidth: cameraImage.width,
      imageMean: 127.5,   // defaults to 127.5
      imageStd: 127.5,    // defaults to 127.5
      rotation: 90,       // defaults to 90, Android only
      numResults: 1,      // defaults to 5
      threshold: 0.8,     // defaults to 0.1
      asynch: true        // defaults to true
    );
    
      if(recognitions != null){
        label = recognitions.toString();
      }
      print(recognitions);
    
  }

  void capture(){
    img.Image image = img.Image.fromBytes(
      _cameraImage.width, 
      _cameraImage.height, 
      _cameraImage.planes[0].bytes, format: img.Format.bgra);

    Uint8List jpeg = Uint8List.fromList(img.encodeJpg(image));
    _imageList.add(jpeg);
    _imageList.refresh();
  }
}