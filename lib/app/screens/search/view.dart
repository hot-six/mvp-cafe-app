import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nado_client_mvp/app/concept/colors.dart';
import 'package:nado_client_mvp/app/screens/search/logic.dart';
import 'package:nado_client_mvp/app/widgets/type_chip.dart';

class ClientSearchPage extends StatelessWidget {
  final ClientSearchPageLogic logic = Get.put(ClientSearchPageLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('카페 유형 선택하기'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: logic.cafeTypeData.keys.length,
                itemBuilder: (context, index) {
                  String cafeTypeKey = logic.cafeTypeData.keys.elementAt(index);

                  return logic.cafeTypeData[cafeTypeKey] != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cafeTypeTile(
                                tileTitle: cafeTypeKey,
                                tileContent: logic.cafeTypeData[cafeTypeKey]!),
                            Divider(
                              height: 4.0,
                              thickness: 4.0,
                              color: NadoColor.greyColor[100],
                            )
                          ],
                        )
                      : SizedBox.shrink();
                }),
          ),
          cafeSearchBottomController(),
        ],
      ),
    );
  }

  Widget cafeTypeTile({
    required String tileTitle,
    required List<String> tileContent,
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
            '$tileTitle 유형',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 14.0),
          Wrap(
            children: List.generate(
              tileContent.length,
              (index) => Obx(
                () => DefaultCafeTypeChip(
                  cafeType: tileContent[index],
                  textColor:
                      logic.selectedCafeTypeList.contains(tileContent[index])
                          ? NadoColor.primary
                          : Colors.black,
                  backgroundColor:
                      logic.selectedCafeTypeList.contains(tileContent[index])
                          ? NadoColor.primary[100]!
                          : NadoColor.greyColor[100]!,
                  isSelected:
                      logic.selectedCafeTypeList.contains(tileContent[index]),
                  onTapAction: () =>
                      logic.onTapCafeTypeUnit(cafeType: tileContent[index]),
                ),
              ),
            ),
            spacing: 9.0,
            runSpacing: 9.0,
          ),
        ],
      ),
    );
  }

  Widget cafeSearchBottomController() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.47),
            blurRadius: 32.0,
            spreadRadius: 0.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => logic.selectedCafeTypeList.isNotEmpty
                ? Column(
                    children: [
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: List.generate(
                          logic.selectedCafeTypeList.length,
                          (index) => DefaultCafeTypeChip(
                            cafeType: logic.selectedCafeTypeList[index],
                            textColor: Colors.white,
                            backgroundColor: NadoColor.primary,
                            isPositionedBottom: true,
                            onTapAction: () => logic.onTapCafeTypeUnit(
                              cafeType: logic.selectedCafeTypeList[index],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  )
                : SizedBox.shrink(),
          ),
          Row(
            children: [
              InkWell(
                onTap: logic.onTapResetSelectedCafeType,
                child: Row(
                  children: [
                    Image.asset('assets/images/reload.png'),
                    SizedBox(width: 9.0),
                    Text(
                      '초기화',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: InkWell(
                  onTap: logic.onTapSubmitSelectedCafeType,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                      color: NadoColor.greyColor[500],
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '선택 완료',
                      style: TextStyle(
                        color: HexColor("#ffffff"),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
