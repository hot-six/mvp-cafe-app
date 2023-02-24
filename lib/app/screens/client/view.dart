import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nado_client_mvp/app/concept/colors.dart';
import 'package:nado_client_mvp/app/concept/theme.dart';
import 'package:nado_client_mvp/app/routes/routes.dart';
import 'package:nado_client_mvp/app/screens/client/logic.dart';
import 'package:nado_client_mvp/app/widgets/appbar.dart';
import 'package:nado_client_mvp/app/widgets/type_chip.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class ClientPage extends StatelessWidget {
  final ClientPageLogic logic = Get.put(ClientPageLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NadoAppBar(),
      body: Stack(
        children: [
          NaverMap(
            onMapCreated: logic.onMapCreated,
            mapType: logic.mapType,
          ),
          Obx(() => Column(
                children: [
                  logic.selectedCafeType.isEmpty
                      ? _searchButton()
                      : _selectedCafeTypeList(),
                  Spacer(),
                  _cafeList(),
                ],
              ))
        ],
      ),
    );
  }

  Widget _searchButton() {
    return InkWell(
      onTap: logic.onTapSearchButton,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        child: Container(
          width: double.infinity,
          height: 48.0,
          decoration: BoxDecoration(
            color: NadoColor.greyColor[500],
            borderRadius: BorderRadius.circular(100.0),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 8.0,
                spreadRadius: 0.0,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 23.0, vertical: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '어떤 카페를 가고 싶은가요?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: HexColor("#ffffff"),
                  ),
                ),
                Image.asset(
                  'assets/images/search.png',
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectedCafeTypeList() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Wrap(
                spacing: 9.0,
                runSpacing: 6.0,
                children: List.generate(
                  logic.selectedCafeType.length,
                  (index) => ColorCustomCafeTypeChip(
                    cafeType: logic.selectedCafeType[index],
                    color: NadoColor.greyColor[500]!,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: logic.onTapSearchButton,
                  child: Image.asset('assets/images/reload.png'),
                ),
                SizedBox(
                  height: 14.0,
                ),
                Image.asset(
                  'assets/images/search.png',
                ),
              ],
            )
          ],
        ));
  }

  Widget _cafeList() {
    return Obx(
      () => GestureDetector(
        child: Container(
          width: double.infinity,
          height: logic.cafeListHeight.value,
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          decoration: BoxDecoration(
            color: HexColor('#ffffff'),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0),
              topRight: Radius.circular(32.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                blurRadius: 24.0,
                spreadRadius: 0.0,
                offset: Offset(0, -8),
              )
            ],
          ),
          child: Column(
            children: [
              GestureDetector(
                child: Image.asset('assets/images/handle.png'),
                onPanUpdate: (DragUpdateDetails details) {
                  if (logic.cafeListHeight.value - details.delta.dy <
                      INITCAFELISTHEIGHT) {
                    logic.cafeListHeight.value = INITCAFELISTHEIGHT;
                  } else {
                    logic.cafeListHeight.value -= details.delta.dy;
                  }
                  print(logic.cafeListHeight);
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: '근처 카페 '),
                    TextSpan(
                        text: '15',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '개'),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              _cafeListTile(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cafeListTile() {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.CAFE_DETAIL + "/1");
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        height: 174.0,
        decoration: BoxDecoration(
          color: NadoColor.greyColor[100],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 150.0,
              width: 150.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  'https://images.squarespace-cdn.com/content/v1/6053751d2b9e3a557fca0abc/c1339efc-db4c-4231-abf7-466f563b1cff/%40charliemckay+_++2698.jpg?format=2500w',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '커피브론즈',
                    style: appTextTheme.headline5,
                  ),
                  Spacer(),
                  Text(
                    '안국역 근처에 있는 디저트 맛집으로 유명한 조용한 카페로 볼 수 있다. 안국역 근처에 있는 디저트 맛집으로 유명한 조용한 카페로 볼 수 있다.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Spacer(),
                  Wrap(
                    spacing: 3.0,
                    runSpacing: 3.0,
                    children: [
                      SmallGreyCafeTypeChip(
                        cafeType: '디저트 맛집',
                      ),
                      SmallGreyCafeTypeChip(
                        cafeType: '뷰 맛집',
                      ),
                      SmallGreyCafeTypeChip(
                        cafeType: '케이크 맛집',
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '영업중',
                        style: appTextTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: NadoColor.primary,
                        ),
                      ),
                      Image.asset(
                        'assets/images/heart.png',
                        color: NadoColor.primary,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
