import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_images/logic.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/widgets/next_step_button.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/widgets/steps_info.dart';

class EnrollCafeImages extends StatelessWidget {
  final PageController pageController;
  final CafeDetail ceoCafeData;
  final EnrollCafeImagesLogic logic;

  EnrollCafeImages({
    required this.pageController,
    required this.ceoCafeData,
  }) : logic = Get.put(EnrollCafeImagesLogic(ceoCafeData: ceoCafeData));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('상세 페이지 사진을 등록해 주세요'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 56.0),
            EnrollStepInfo(step: 2),
            Spacer(),
            _threeImageSlots(),
            SizedBox(height: 22.0),
            Text(
              '최대 3장의 사진을 한 장씩 선택 가능합니다.',
              style: TextStyle(fontSize: 16.0, color: NadoColor.greyColor[400]),
            ),
            SizedBox(height: 2.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/question.png'),
                SizedBox(width: 10.0),
                Text(
                  '카페 상세 페이지에 노출될 사진입니다.',
                  style: TextStyle(
                    color: NadoColor.greyColor,
                  ),
                ),
              ],
            ),
            Spacer(),
            Obx(
              () => NextStepButton(
                isDisabled: logic.imageSource.length == 0,
                onTapAction: () {
                  logic.saveDataAndNextStep(pageController);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _threeImageSlots() {
    return Obx(() => InkWell(
          onTap: () {
            if (logic.imageSource.length < 3)
              logic.selectImage(pickerType: ImagePickType.GALLERY);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 16.0),
              ...List.generate(
                logic.imageSource.length,
                (index) => Row(
                  children: [
                    _imageSlots(
                      imageIndex: index,
                      imageFile: logic.imageSource[index].imageUrl,
                    ),
                    SizedBox(width: 16.0),
                  ],
                ),
              ),
              ...List.generate(
                3 - logic.imageSource.length,
                (index) => Row(
                  children: [
                    _imageSlots(
                      imageIndex: logic.imageSource.length + index,
                      imageFile: null,
                    ),
                    SizedBox(width: 16.0),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _imageSlots({required int imageIndex, String? imageFile}) {
    Uint8List imageSource = base64.decode(imageFile ?? '');

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 98.0,
          height: 98.0,
          decoration: BoxDecoration(
            color: NadoColor.greyColor[100],
            border: Border.all(
              width: 2.0,
              color: NadoColor.greyColor[200]!,
            ),
            borderRadius: BorderRadius.circular(9.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: imageFile != null
                ? Image.memory(
                    imageSource,
                    fit: BoxFit.cover,
                  )
                : Center(
                    child: Image.asset(
                      'assets/images/upload_image.png',
                      width: 46.0,
                      height: 46.0,
                      color: NadoColor.greyColor,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
        if (imageFile != null)
          Positioned(
            right: -12.5,
            top: -12.5,
            child: InkWell(
              onTap: () {
                logic.deleteImage(imageIndex);
              },
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(
                    Icons.cancel,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
