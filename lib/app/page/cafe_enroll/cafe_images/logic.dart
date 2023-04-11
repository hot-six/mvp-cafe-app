import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/data/model/image.dart';

enum ImagePickType { CAMERA, GALLERY }

class EnrollCafeImagesLogic extends GetxController {
  final CafeDetail ceoCafeData;
  final ImagePicker _picker = ImagePicker();
  RxList<CafeImage> imageSource = <CafeImage>[].obs;

  EnrollCafeImagesLogic({required this.ceoCafeData});

  void selectImage({required ImagePickType pickerType}) async {
    XFile? _selectedImage;

    if (pickerType == ImagePickType.CAMERA)
      _selectedImage = await _picker.pickImage(source: ImageSource.camera);
    else
      _selectedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (_selectedImage != null) {
      File uploadedImage = File(_selectedImage.path);
      Uint8List imageUint8List = await uploadedImage.readAsBytes();

      String imageString = base64.encode(imageUint8List);

      imageSource.add(
        CafeImage(
          imageUrl: imageString,
          imageName: 'thumbnail',
          imageType: 'jpg',
        ),
      );

      imageSource.refresh();
    }
  }

  void deleteImage(int index) {
    imageSource.removeAt(index);
    imageSource.refresh();
  }

  void saveDataAndNextStep(PageController pageController) async {
    ceoCafeData.images = imageSource;

    pageController.animateToPage(
      2,
      duration: Duration(microseconds: 500),
      curve: Curves.linear,
    );
  }
}
