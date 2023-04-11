import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/global_widgets/loading_indicator.dart';
import 'package:nado_client_mvp/app/page/cafe_edit/logic.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_form/view.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_images/view.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_thumbnail/view.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_types/view.dart';

class CafeEditPage extends StatelessWidget {
  final CafeEditPageLogic logic = Get.put(CafeEditPageLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => logic.isLoaded.value
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  controller: logic.pageController,
                  children: [
                    EnrollCafeThumbnail(
                      ceoCafeData: logic.ceoCafeTile,
                      pageController: logic.pageController,
                    ),
                    EnrollCafeImages(
                      ceoCafeData: logic.ceoCafeDetail,
                      pageController: logic.pageController,
                    ),
                    EnrollCafeTypes(
                      ceoCafeDetailData: logic.ceoCafeDetail,
                      ceoCafeTileData: logic.ceoCafeTile,
                      pageController: logic.pageController,
                    ),
                    EnrollCafeForm(
                      ceoCafeDetailData: logic.ceoCafeDetail,
                      ceoCafeTileData: logic.ceoCafeTile,
                      onSubmit: logic.saveUpdateData,
                    ),
                  ],
                ),
              )
            : Center(
                child: LoadingIndicator(),
              ),
      ),
    );
  }
}
