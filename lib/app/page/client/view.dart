import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/global_widgets/loading_indicator.dart';
import 'package:nado_client_mvp/app/page/client/logic.dart';
import 'package:nado_client_mvp/app/global_widgets/appbar/view.dart';
import 'package:nado_client_mvp/app/global_widgets/type_chip.dart';

import 'widget/cafe_list_tile/view.dart';

class ClientPage extends StatelessWidget {
  final ClientPageLogic logic = Get.put(ClientPageLogic(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: NadoAppBar(),
        body: Stack(
          children: [
            logic.isMapLoaded.value
                ? NaverMap(
                    initLocationTrackingMode: LocationTrackingMode.Follow,
                    onMapCreated: logic.onMapCreated,
                    mapType: logic.mapType,
                    initialCameraPosition:
                        logic.searchPagingController.itemList == null ||
                                logic.totalNumberOfSearchedCafe == 0
                            ? null
                            : CameraPosition(
                                target: LatLng(
                                  logic.searchPagingController.itemList![0]
                                      .latitude,
                                  logic.searchPagingController.itemList![0]
                                      .longitude,
                                ),
                              ),
                    markers: logic.mapMarkerList,
                  )
                : Center(
                    child: LoadingIndicator(),
                  ),
            Column(
              children: [
                logic.selectedCafeType.isEmpty
                    ? _searchButton()
                    : _selectedCafeTypeList(),
                Spacer(),
                _cafeListView(context),
              ],
            ),
          ],
        ),
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
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
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
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 80.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Wrap(
                  spacing: 9.0,
                  runSpacing: 6.0,
                  children: List.generate(
                    logic.selectedCafeType.length,
                    (index) => ColorCustomCafeTypeChip(
                      cafeType: logic.selectedCafeType[index].typeName,
                      color: NadoColor.greyColor[500]!,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: logic.onTapSearchResetButton,
                  child: Image.asset('assets/images/reload.png'),
                ),
                InkWell(
                  onTap: logic.onTapSearchButton,
                  child: Image.asset(
                    'assets/images/search.png',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _cafeListView(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: logic.cafeListHeight.value,
        padding: EdgeInsets.only(
          bottom: 10.0,
          right: 10.0,
          left: 10.0,
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                height: 15.0,
                width: 100.0,
                child: Image.asset('assets/images/handle.png'),
              ),
            ),
            Row(
              children: [
                SizedBox(width: 10.0),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text:
                              '${logic.isShowFavoriteCafeList.value ? "관심" : logic.selectedCafeType.length > 0 ? "검색" : "근처"} 카페 '),
                      TextSpan(
                          text:
                              '${logic.isShowFavoriteCafeList.value ? logic.totalNumberOfFavoriteCafe : logic.totalNumberOfSearchedCafe}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: '개'),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  child: Text('관심 카페 목록 보기'),
                ),
                Switch(
                  value: logic.isShowFavoriteCafeList.value,
                  onChanged: (value) {
                    logic.controlShowFavoriteCafeToggle();
                  },
                ),
              ],
            ),
            Expanded(
              child: logic.isShowFavoriteCafeList.value
                  ? _favoriteCafeList()
                  : _searchedCafeList(),
            ),
          ],
        ),
      ),
      onPanUpdate: (DragUpdateDetails details) =>
          logic.onChangeCafeListHeight(context, details: details),
      onPanEnd: (DragEndDetails details) => logic.onTapOutCafeList(context),
    );
  }

  Widget _favoriteCafeList() {
    return Obx(
      () => PagedListView(
        physics: logic.cafeListHeightStatus != CafeListHeightType.MAX
            ? NeverScrollableScrollPhysics()
            : null,
        scrollController: logic.cafeListScrollController,
        pagingController: logic.searchPagingController,
        builderDelegate: PagedChildBuilderDelegate<CafeTile>(
          itemBuilder: (context, item, index) {
            return CafeListTile(
              cafeTileData: item,
              initFavoriteState: logic.favoriteCafeIdList.contains(item.id),
            );
          },
          noItemsFoundIndicatorBuilder: (context) {
            return Center(
              child: Text('관심 카페가 없습니다.'),
            );
          },
          firstPageProgressIndicatorBuilder: (context) {
            return Center(child: LoadingIndicator());
          },
        ),
      ),
    );
  }

  Widget _searchedCafeList() {
    return Obx(
      () => PagedListView(
        physics: logic.cafeListHeightStatus != CafeListHeightType.MAX
            ? NeverScrollableScrollPhysics()
            : null,
        scrollController: logic.cafeListScrollController,
        pagingController: logic.searchPagingController,
        builderDelegate: PagedChildBuilderDelegate<CafeTile>(
          itemBuilder: (context, item, index) {
            return CafeListTile(
              cafeTileData: item,
              initFavoriteState: logic.favoriteCafeIdList.contains(item.id),
            );
          },
          noItemsFoundIndicatorBuilder: (context) {
            return Center(
              child: Text('해당 카페가 없습니다.'),
            );
          },
          firstPageProgressIndicatorBuilder: (context) {
            return Center(child: LoadingIndicator());
          },
        ),
      ),
    );
  }
}
