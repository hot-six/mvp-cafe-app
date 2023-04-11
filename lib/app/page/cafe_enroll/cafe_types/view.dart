import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/data/model/type.dart';
import 'package:nado_client_mvp/app/global_widgets/loading_indicator.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/cafe_types/logic.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/widgets/next_step_button.dart';
import 'package:nado_client_mvp/app/page/cafe_enroll/widgets/steps_info.dart';
import 'package:nado_client_mvp/app/global_widgets/type_chip.dart';

class EnrollCafeTypes extends StatelessWidget {
  final PageController pageController;
  final CafeDetail ceoCafeDetailData;
  final CafeTile ceoCafeTileData;
  final EnrollCafeTypesLogic logic;

  EnrollCafeTypes({
    required this.ceoCafeDetailData,
    required this.ceoCafeTileData,
    required this.pageController,
  }) : logic = Get.put(EnrollCafeTypesLogic(
          ceoCafeDetailData: ceoCafeDetailData,
          ceoCafeTileData: ceoCafeTileData,
        ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('카페 유형을 선택해 주세요.'),
      ),
      body: SafeArea(
        child: Obx(
          () => logic.isLoaded.value
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => logic.selectedCafeTypes.isEmpty
                          ? Column(
                              children: [
                                SizedBox(height: 109.0),
                                EnrollStepInfo(step: 3),
                                SizedBox(height: 121.0),
                                Text(
                                  '카페에 해당되는 모든 유형을 선택해주세요.',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: NadoColor.greyColor),
                                ),
                              ],
                            )
                          : selectedCafeTypeList(),
                    ),
                    SizedBox(height: 28.0),
                    InkWell(
                      onTap: () => logic.getUserSelectedCafeType(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 14.0),
                        decoration: BoxDecoration(
                          color: NadoColor.greyColor[200]!,
                          border: Border.all(
                            color: NadoColor.greyColor[100]!,
                          ),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: Obx(
                          () => Text(
                            logic.selectedCafeTypes.isNotEmpty
                                ? '다시 선택하기'
                                : '유형 선택하기',
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
                        isDisabled: logic.selectedCafeTypes.isEmpty,
                        onTapAction: () {
                          logic.saveDataAndNextStep(pageController);
                        },
                      ),
                    ),
                  ],
                )
              : Center(child: LoadingIndicator()),
        ),
      ),
    );
  }

  Widget selectedCafeTypeList() {
    return Column(
      children: List.generate(
        logic.selectedCafeTypes.keys.length,
        (index) {
          CafeCategoryType categoryType =
              logic.selectedCafeTypes.keys.toList()[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cafeTypeTile(
                  tileType: categoryType,
                  tileContent: logic.selectedCafeTypes[categoryType]!),
              Divider(
                height: 4.0,
                thickness: 4.0,
                color: NadoColor.greyColor[100],
              )
            ],
          );
        },
      ),
    );
  }

  Widget cafeTypeTile({
    required CafeCategoryType tileType,
    required List<CafeType> tileContent,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 33.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${tileType.displayName} 유형',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 14.0),
          Wrap(
            children: List.generate(
              tileContent.length,
              (index) => DefaultCafeTypeChip(
                cafeType: tileContent[index].typeName,
                textColor: Colors.white,
                backgroundColor: NadoColor.primary,
                isPositionedBottom: true,
                onTapAction: () {},
              ),
            ),
            spacing: 9.0,
            runSpacing: 9.0,
          ),
        ],
      ),
    );
  }
}
