import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/data/model/image.dart';

enum ImagePickType { CAMERA, GALLERY }

class EnrollCafeThumbnailLogic extends GetxController {
  final CafeTile ceoCafeData;
  final ImagePicker _picker = ImagePicker();
  // Rx<File> imageSource = File('').obs;
  Rx<Uint8List> imageSource = Uint8List(0).obs;

  EnrollCafeThumbnailLogic({required this.ceoCafeData});

  void selectImage({required ImagePickType pickerType}) async {
    XFile? _selectedImage;

    if (pickerType == ImagePickType.CAMERA)
      _selectedImage = await _picker.pickImage(source: ImageSource.camera);
    else
      _selectedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (_selectedImage != null) {
      File imageFile = File(_selectedImage.path);

      imageSource.value = await imageFile.readAsBytes();
    }
  }

  void saveDataAndNextStep(PageController pageController) async {
    ceoCafeData.thumbnail = CafeImage(
      imageUrl: base64.encode(imageSource.value),
      imageName: 'thumbnail',
      imageType: 'jpg',
    );

    pageController.animateToPage(
      1,
      duration: Duration(microseconds: 500),
      curve: Curves.linear,
    );
  }
}
