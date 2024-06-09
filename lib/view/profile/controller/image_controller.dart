// ignore_for_file: unused_import, deprecated_member_use, prefer_interpolation_to_compose_strings, unused_local_variable

import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageController extends GetxController {
  File? image;
  RxString? imgPath = ''.obs;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      File? img = File(image.path);
      img = await cropImage(imageFile: img);
      await saveData(img!.path);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

//The photos were cropped into a square shape and then processed using ImageCropper to ensure they do not create any issues.
  Future<File?> cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
     
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  Future<void> saveData(String val) async {
    //verinin key value şeklinde tutar,yani seçilen resmin yolunu set eder
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('path', val);
    getData(); //set edildikten sonra data bu set edilen veriyi okuyup kaydediyor.
  }

//resmnin yolunu localde kaydetmk için
  Future<void> getData() async {
    final sharedPref = await SharedPreferences.getInstance();
    imgPath!.value = sharedPref.getString('path') as String;
    log("GetData : " + imgPath!.value);
  }

//resmi kaldırmak için
  void deleteData() async {
    final sharedPref = await SharedPreferences.getInstance();
    sharedPref.remove('path');
    imgPath!.value = '';
    getData();
  }
}