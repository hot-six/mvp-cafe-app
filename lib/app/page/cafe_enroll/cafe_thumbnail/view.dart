import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_thumbnail/logic.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/widgets/next_step_button.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/widgets/steps_info.dart';

class EnrollCafeThumbnail extends StatelessWidget {
  final CafeTile ceoCafeData;
  final PageController pageController;
  final EnrollCafeThumbnailLogic logic;

  EnrollCafeThumbnail({required this.ceoCafeData, required this.pageController})
      : logic = Get.put(EnrollCafeThumbnailLogic(ceoCafeData: ceoCafeData));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('썸네일 사진을 등록해주세요.'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 56.0),
            EnrollStepInfo(step: 1),
            Spacer(),
            Obx(
              () => logic.imageSource.value.isNotEmpty
                  ? showUploadedImage(context)
                  : Column(
                      children: [
                        Image.asset('assets/images/upload_image.png'),
                        SizedBox(height: 22.0),
                        Text(
                          '최대 1장의 사진 선택 가능합니다.',
                          style: TextStyle(
                              fontSize: 16.0, color: NadoColor.greyColor[400]),
                        ),
                      ],
                    ),
            ),
            SizedBox(height: 28.0),
            InkWell(
              onTap: () {
                logic.selectImage(pickerType: ImagePickType.GALLERY);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
                decoration: BoxDecoration(
                  color: NadoColor.greyColor[200]!,
                  border: Border.all(
                    color: NadoColor.greyColor[100]!,
                  ),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Obx(
                  () => Text(
                    logic.imageSource.value.isEmpty ? '사진 선택하기' : '다시 선택하기',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Obx(
              () => NextStepButton(
                isDisabled: logic.imageSource.value.isEmpty,
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

  Widget showUploadedImage(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width * 0.6;
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          width: imageSize,
          height: imageSize,
          child: Image.memory(
            logic.imageSource.value,
            fit: BoxFit.cover,
          ),
        ));
  }
}
