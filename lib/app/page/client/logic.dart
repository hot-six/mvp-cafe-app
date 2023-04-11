import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/data/model/type.dart';
import 'package:nado_client_mvp/app/data/provider/extensions/base.dart';
import 'package:nado_client_mvp/app/data/provider/extensions/cafe_provider.dart';
import 'package:nado_client_mvp/app/data/provider/storage_provider.dart';
import 'package:nado_client_mvp/app/page/search/view.dart';

const double INITCAFELIST_MINIMUMHEIGHT = 95.0;

class ClientPageLogic extends GetxController {
  final PagingController<int, CafeTile> searchPagingController =
      PagingController(firstPageKey: 0);

  final RxDouble cafeListHeight = 290.0.obs;
  final RxList<CafeType> selectedCafeType = <CafeType>[].obs;
  final RxList<int> favoriteCafeIdList = <int>[].obs;
  final RxList<CafeTile> favoriteCafeList = <CafeTile>[].obs;
  final RxList<Marker> mapMarkerList = <Marker>[].obs;
  final RxInt totalNumberOfSearchedCafe = 0.obs;
  final RxInt totalNumberOfFavoriteCafe = 0.obs;

  final RxBool isMapLoaded = false.obs;
  final RxBool isShowFavoriteCafeList = false.obs;

  final MapType mapType = MapType.Basic;
  Completer<NaverMapController> mapController = Completer();

  @override
  void onInit() async {
    searchPagingController.addPageRequestListener((pageKey) {
      if (isShowFavoriteCafeList.value) {
        _fetchFavoriteCafeList(pageKey);
      } else {
        _fetchCafeList(pageKey);
      }
    });

    await getFavoriteCafeList();

    super.onInit();
  }

  @override
  void dispose() {
    searchPagingController.dispose();
    super.dispose();
  }

  void onMapCreated(NaverMapController controller) {
    if (mapController.isCompleted) mapController = Completer();
    mapController.complete(controller);
  }

  void onTapSearchButton() async {
    await Get.to(() => ClientSearchPage(), arguments: {
          'selectedTypes': selectedCafeType,
          'wantMapType': false,
        }) ??
        [];

    mapMarkerList.clear();
    searchPagingController.refresh();
  }

  void onTapSearchResetButton() async {
    selectedCafeType.clear();
    searchPagingController.refresh();
  }

  void onChangeCafeListHeight(context, {required DragUpdateDetails details}) {
    final maximunCafeListHeight = MediaQuery.of(context).size.height - 200.0;

    if (cafeListHeight.value - details.delta.dy < INITCAFELIST_MINIMUMHEIGHT) {
      cafeListHeight.value = INITCAFELIST_MINIMUMHEIGHT;
    } else if (cafeListHeight.value - details.delta.dy >
        maximunCafeListHeight) {
      cafeListHeight.value = maximunCafeListHeight;
    } else {
      cafeListHeight.value -= details.delta.dy;
    }
  }

  Future<void> getFavoriteCafeList() async {
    final Storage storage = Storage();
    favoriteCafeIdList.value = await storage.getFavoriteCafe();
  }

  Future<void> _fetchCafeList(int pageKey) async {
    final NadoProvider provider = Get.find<NadoProvider>();
    try {
      var response = await provider.getCafeList(
        filterTypes: selectedCafeType
            .map(
              (cafeType) => cafeType.type,
            )
            .toList(),
        pageKey: pageKey,
      );

      if (response.isOk && response.body != null) {
        var responseInfo = response.body!;

        if (totalNumberOfSearchedCafe.value != responseInfo.totalElements)
          totalNumberOfSearchedCafe.value = responseInfo.totalElements;

        List<CafeTile> responseCafeTileData = responseInfo.contents;

        if (responseInfo.last) {
          searchPagingController.appendLastPage(
            responseCafeTileData,
          );
        } else {
          searchPagingController.appendPage(
            responseCafeTileData,
            responseInfo.pageable.pageNumber + 1,
          );
        }

        _setMapPointer(newCafeList: responseCafeTileData);
      }
    } catch (error) {
      printError(info: "Failed to load cafe list infomation");
      searchPagingController.error = error;
    }
  }

  Future<void> _fetchFavoriteCafeList(int pageKey) async {
    final NadoProvider provider = Get.find<NadoProvider>();

    try {
      final Storage storage = Storage();

      favoriteCafeIdList.value = await storage.getFavoriteCafe();

      var response = await provider.getFavoriteCafeList(
        favoriteCafeIdList: favoriteCafeIdList,
        pageKey: pageKey,
      );

      if (response.isOk && response.body != null) {
        var responseInfo = response.body!;

        if (totalNumberOfFavoriteCafe.value != responseInfo.totalElements)
          totalNumberOfFavoriteCafe.value = responseInfo.totalElements;

        List<CafeTile> responseFavoriteCafeTileData = responseInfo.contents;

        if (responseInfo.last) {
          searchPagingController.appendLastPage(
            responseFavoriteCafeTileData,
          );
        } else {
          searchPagingController.appendPage(
            responseFavoriteCafeTileData,
            responseInfo.pageable.pageNumber + 1,
          );
        }
      }
    } on Exception catch (error) {
      printError(info: "Failed to load favorite cafe infomation");
      searchPagingController.error = error;
    }
  }

  Future<void> _setMapPointer({required List<CafeTile> newCafeList}) async {
    isMapLoaded.value = false;
    OverlayImage markerIcon = await OverlayImage.fromAssetImage(
      assetName: 'assets/images/marker.png',
    );

    mapMarkerList.addAll(newCafeList.map(
      (CafeTile cafe) {
        return Marker(
          markerId: 'cafe_${cafe.id}',
          position: LatLng(cafe.latitude, cafe.longitude),
          captionText: '${cafe.cafeName}',
          captionTextSize: 10.0,
          icon: markerIcon,
          width: 30,
          height: 35,
        );
      },
    ).toList());

    isMapLoaded.value = true;
  }

  void controlShowFavoriteCafeToggle() async {
    isShowFavoriteCafeList.value = !isShowFavoriteCafeList.value;

    searchPagingController.refresh();
  }
}
