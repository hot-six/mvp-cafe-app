import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/data/model/menu.dart';
import 'package:nado_client_mvp/app/data/model/schedule.dart';
import 'package:nado_client_mvp/app/global_widgets/loading_indicator.dart';
import 'package:nado_client_mvp/app/page/cafe_detail/logic.dart';
import 'package:nado_client_mvp/app/routes/routes.dart';
import 'package:nado_client_mvp/app/utils/price.dart';
import 'package:nado_client_mvp/app/global_widgets/color_tabbar.dart';
import 'package:nado_client_mvp/app/global_widgets/type_chip.dart';

class CafeDetailPage extends StatelessWidget {
  final CafeDetailPageLogic logic = Get.put(CafeDetailPageLogic());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: logic.tabList.length,
      child: Scaffold(
        body: Obx(
          () => logic.isLoaded.value || logic.cafeData.id != 0
              ? NestedScrollView(
                  controller: logic.scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: _cafeAppBar(context, innerBoxIsScrolled),
                      )
                    ];
                  },
                  body: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: TabBarView(
                      children: logic.tabList.map((String tabType) {
                        return Builder(
                          builder: ((BuildContext context) {
                            return CustomScrollView(
                              slivers: [
                                SliverOverlapInjector(
                                  handle: NestedScrollView
                                      .sliverOverlapAbsorberHandleFor(context),
                                ),
                                SliverPadding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  sliver: SliverToBoxAdapter(
                                    child: selectTabContent(context, tabType),
                                  ),
                                ),
                              ],
                            );
                          }),
                        );
                      }).toList(),
                    ),
                  ))
              : Container(
                  child: Center(
                    child: LoadingIndicator(),
                  ),
                ),
        ),
      ),
    );
  }

  Widget selectTabContent(BuildContext context, String tabType) {
    switch (tabType) {
      case '기본 정보':
        return _cafeDetailInfomation();
      case '메뉴':
        return _cafeMenuList();
      case '위치':
        return _cafeLocation(context);
      default:
        return _cafeDetailInfomation();
    }
  }

  Widget _cafeAppBar(BuildContext context, bool innerBoxIsScrolled) {
    return SliverAppBar(
      pinned: true,
      title: Opacity(
        opacity: logic.isAppBarShrink.value ? 1.0 : 0.0,
        child: Text(
          '${logic.cafeData.cafeName}',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: _cafeThumbnailWithInfo(
          context,
        ),
      ),
      expandedHeight: Get.height * 0.6,
      forceElevated: innerBoxIsScrolled,
      actions: [
        if (logic.cafeData.images.length > 1)
          Opacity(
            opacity: logic.isAppBarShrink.value ? 0.0 : 1.0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 18.0,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: HexColor('#060606'),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                alignment: Alignment.center,
                child: Obx(
                  () => Text.rich(
                    style: TextStyle(fontSize: 14.0),
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${logic.thumbnailCarouselIndex.value + 1}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '/${logic.cafeData.images.length}',
                          style: TextStyle(
                            color: NadoColor.greyColor[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
      bottom: ColoredTabBarWithBottomBorder(
        tabBar: TabBar(
          tabs: [
            Tab(
              text: '기본 정보',
              height: 60,
            ),
            Tab(
              text: '메뉴',
              height: 60,
            ),
            Tab(
              text: '위치',
              height: 60,
            ),
          ],
          indicatorColor: NadoColor.primary,
          labelColor: NadoColor.primary,
          labelStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          unselectedLabelColor: NadoColor.greyColor[400],
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  Widget _cafeThumbnailWithInfo(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, NadoColor.greyColor[500]!],
                stops: [0.3, 1],
              ).createShader(rect);
            },
            child: logic.cafeData.images.isNotEmpty
                ? CarouselSlider(
                    options: CarouselOptions(
                      enableInfiniteScroll: logic.cafeData.images.length > 1,
                      height: double.infinity,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        logic.thumbnailCarouselIndex.value = index;
                      },
                    ),
                    items: List.generate(
                      logic.cafeData.images.length,
                      (index) => Image.memory(
                        Base64Codec()
                            .decode(logic.cafeData.images[index].imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Image.asset(
                    'assets/images/no_detail_image.png',
                    height: 580.0,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Positioned(
          bottom: 100.0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  logic.fromCeoPage
                      ? InkWell(
                          onTap: () {
                            Get.toNamed(Routes.CEO_EDIT);
                          },
                          child: Image.asset('assets/images/edit.png'),
                        )
                      : Obx(
                          () => InkWell(
                            onTap: logic.toggleFavoriteCafe,
                            child: logic.isFavorite.value
                                ? Image.asset(
                                    'assets/images/heart_fill.png',
                                    color: NadoColor.primary,
                                    width: 28.0,
                                  )
                                : Image.asset(
                                    'assets/images/heart.png',
                                    color: Colors.white,
                                    width: 28.0,
                                  ),
                          ),
                        ),
                  SizedBox(height: 10.0),
                  Text(
                    '${logic.cafeData.cafeName}',
                    style: TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                      logic.cafeData.cafeTypes.length,
                      (index) => ColorCustomCafeTypeChip(
                        cafeType: logic.cafeData.cafeTypes[index].typeName,
                        color: logic.cafeData.cafeTypes[index].isTypeSelected ==
                                true
                            ? NadoColor.primary
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
        greyDivider,
        _cafeDescription(),
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
                    color: dayData.isOpen == true
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
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.only(bottom: 14.0),
      title: Row(
        children: [
          Image.asset('assets/images/clock.png'),
          SizedBox(width: 14.0),
          Text(
            '영업 시간',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 31.0),
          Text(
            '${logic.cafeData.mainSchedule.startTime} - ${logic.cafeData.mainSchedule.endTime}',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
      children: [
        Column(
          children: List.generate(
            logic.cafeData.schedules.length,
            (index) {
              CafeSchedule daySchedule = logic.cafeData.schedules[index];
              return Text(
                '${daySchedule.weekDayName} | ${daySchedule.startTime} - ${daySchedule.endTime}',
                style: TextStyle(
                  fontSize: 12.0,
                  color: NadoColor.greyColor[400],
                  height: 1.3,
                ),
              );
            },
          ),
        ),
      ],
      textColor: Colors.black,
      iconColor: Colors.black,
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

  Widget _cafeDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/home.png'),
          SizedBox(width: 14.0),
          Text(
            '카페 설명',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 31.0),
          Obx(
            () => Expanded(
              child: logic.cafeData.cafeDescription != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${logic.cafeData.cafeDescription}',
                          style: TextStyle(fontSize: 16.0),
                          overflow: logic.isCollapsed.value
                              ? TextOverflow.ellipsis
                              : null,
                          maxLines: logic.isCollapsed.value ? 2 : null,
                        ),
                        SizedBox(height: 3.0),
                        InkWell(
                          onTap: () {
                            logic.isCollapsed.value = !logic.isCollapsed.value;
                          },
                          child: Text(
                            logic.isCollapsed.value ? '더보기' : '접기',
                            style: TextStyle(
                              color: NadoColor.greyColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cafeMenuList() {
    return logic.cafeData.menus.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 0.0),
            itemCount: logic.cafeData.menus.length,
            itemBuilder: (context, index) {
              Menu cafeMenu = logic.cafeData.menus[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      height: 90.0,
                      child: Column(
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
                          cafeMenu.description != null
                              ? Text(
                                  cafeMenu.description!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                )
                              : SizedBox.shrink(),
                          Text(
                            '${displayIntegerPrice(cafeMenu.price)}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: NadoColor.grapefruit,
                            ),
                          ),
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
          )
        : Container(
            child: Center(
              child: Text('등록된 메뉴가 없습니다.'),
            ),
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
                Expanded(
                  child: Text(
                    '${logic.cafeData.cafeAddress}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                InkWell(
                  onTap: logic.copyAddress,
                  child: Text(
                    '복사',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: NadoColor.greyColor[300],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Container(
              height: 250.0,
              child: NaverMap(
                useSurface: kReleaseMode,
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
                    icon: logic.markerIcon,
                    width: 30,
                    height: 35,
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
