import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/concept/colors.dart';
import 'package:nado_client_mvp/app/model/menu.dart';
import 'package:nado_client_mvp/app/model/schedule.dart';
import 'package:nado_client_mvp/app/screens/cafe/logic.dart';
import 'package:nado_client_mvp/app/utils/price.dart';
import 'package:nado_client_mvp/app/widgets/type_chip.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class CafeDetailPage extends StatelessWidget {
  final CafeDetailPageLogic logic = Get.put(CafeDetailPageLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          _cafeThumbnailWithInfo(context),
          Expanded(child: _cafeInfoTapView(context)),
        ],
      ),
    );
  }

  Widget _cafeThumbnailWithInfo(BuildContext context) {
    Uint8List blobImage =
        Base64Codec().decode(logic.cafeData.thumbnail.imageUrl);
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, NadoColor.greyColor[500]!],
              stops: [0.5, 1],
            ).createShader(rect);
          },
          child: Image.memory(
            blobImage,
            height: 580.0,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/2.0x/heart.png',
                  color: Colors.white,
                ),
                SizedBox(height: 5.0),
                Text(
                  '${logic.cafeData.cafeName}',
                  style: TextStyle(
                    fontSize: 34.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12.0),
                Text('${logic.cafeData.cafeDescription}',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                SizedBox(height: 12.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                      logic.cafeData.types.length,
                      (index) => ColorCustomCafeTypeChip(
                        cafeType: logic.cafeData.types[index].typeName,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 79.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _cafeInfoTapView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 64,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2.0,
                      color: NadoColor.greyColor[200]!,
                    ),
                  ),
                ),
              ),
              TabBar(
                controller: logic.tabController,
                tabs: [
                  Container(
                    padding: EdgeInsets.only(top: 26.0, bottom: 13.0),
                    child: Text('기본 정보'),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 26.0, bottom: 13.0),
                    child: Text('메뉴'),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 26.0, bottom: 13.0),
                    child: Text('위치'),
                  ),
                ],
                indicatorColor: NadoColor.primary,
                labelColor: NadoColor.primary,
                labelStyle:
                    TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                unselectedLabelColor: NadoColor.greyColor[400],
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TabBarView(
                controller: logic.tabController,
                children: [
                  _cafeDetailInfomation(),
                  _cafeMenuList(),
                  _cafeMenuList(),
                  _cafeLocation(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cafeDetailInfomation() {
    Widget greyDivider = Divider(
      thickness: 1.0,
      height: 1.0,
      color: NadoColor.greyColor[100],
    );
    return Column(
      children: [
        _cafeOpenDay(),
        greyDivider,
        _cafeOpenTime(),
        greyDivider,
        _cafePhoneNumber(),
      ],
    );
  }

  Widget _cafeOpenDay() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Row(
        children: [
          Image.asset('assets/images/calendar.png'),
          SizedBox(width: 14.0),
          Text(
            '영업 요일',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 31.0),
          ...List.generate(logic.cafeData.schedules.length, (index) {
            CafeSchedule dayData = logic.cafeData.schedules[index];
            return Row(
              children: [
                Container(
                  width: 22.0,
                  height: 22.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dayData.isOpen == 'Y'
                        ? NadoColor.primary
                        : NadoColor.greyColor[300]!,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    dayData.weekDayName,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 5.0),
              ],
            );
          })
        ],
      ),
    );
  }

  Widget _cafeOpenTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Row(
        children: [
          Image.asset('assets/images/clock.png'),
          SizedBox(width: 14.0),
          Text(
            '영업 시간',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 31.0),
          Text(
            '${logic.cafeData.cafeNumber}',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _cafePhoneNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Row(
        children: [
          Image.asset('assets/images/phone.png'),
          SizedBox(width: 14.0),
          Text(
            '매장 번호',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 31.0),
          Text(
            '${logic.cafeData.cafeNumber}',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  Widget _cafeMenuList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 0.0),
      itemCount: logic.cafeData.menus.length,
      itemBuilder: (context, index) {
        Menu cafeMenu = logic.cafeData.menus[index];
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                height: 90.0,
                child: Row(
                  children: [
                    // TODO : 이미지 필요
                    Container(
                      color: NadoColor.greyColor,
                      width: 90.0,
                    ),
                    SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${cafeMenu.name}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // TODO : 카페 설명 필요
                        Text('카페 설명'),
                        Text(
                          '${displayIntegerPrice(cafeMenu.price)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: NadoColor.grapefruit,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1.0,
              height: 1.0,
              color: NadoColor.greyColor[100],
            ),
          ],
        );
      },
    );
  }

  Widget _cafeLocation(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${logic.cafeData.cafeAddress}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  '복사',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: NadoColor.greyColor[300],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Container(
              height: 250.0,
              child: NaverMap(
                onMapCreated: (NaverMapController controller) {
                  if (logic.mapController.isCompleted)
                    logic.mapController = Completer();
                  logic.mapController.complete(controller);
                },
                symbolScale: 0.8,
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(logic.cafeData.latitude, logic.cafeData.longitude),
                ),
                markers: [
                  Marker(
                    markerId: 'cafe_${logic.cafeData.id}',
                    position: LatLng(
                        logic.cafeData.latitude, logic.cafeData.longitude),
                    captionText: '${logic.cafeData.cafeName}',
                    captionTextSize: 10.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
