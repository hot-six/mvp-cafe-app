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
import 'package:nado_client_mvp/app/page/client/widget/cafe_list_tile/view.dart';
import 'package:nado_client_mvp/app/page/search/view.dart';

const double INITCAFELIST_MINIMUM_HEIGHT = 95.0;
const double INITCAFELIST_DEFULT_HEIGHT = 290.0;

const double CAFELIST_CHANGABLE_POINT = 20.0;

enum CafeListHeightType {
  MIN,
  DEFAULT,
  MAX,
}

class ClientPageLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  final PagingController<int, CafeTile> searchPagingController =
      PagingController(firstPageKey: 0);

  final Rx<CafeListHeightType> cafeListHeightStatus =
      CafeListHeightType.MIN.obs;
  final RxDouble cafeListHeight = INITCAFELIST_DEFULT_HEIGHT.obs;
  final RxList<CafeType> selectedCafeType = <CafeType>[].obs;
  final RxList<int> favoriteCafeIdList = <int>[].obs;
  final RxList<CafeTile> favoriteCafeList = <CafeTile>[].obs;
  final RxList<Marker> mapMarkerList = <Marker>[].obs;
  final RxInt totalNumberOfSearchedCafe = 0.obs;
  final RxInt totalNumberOfFavoriteCafe = 0.obs;

  final RxBool isMapLoaded = false.obs;
  final RxBool isShowFavoriteCafeList = false.obs;

  double maxLatitude = 0.0;
  double minLatitude = 0.0;
  double maxLongitude = 0.0;
  double minLongitude = 0.0;

  LatLng southWestMarker = LatLng(0.0, 0.0);
  LatLng northEastMarker = LatLng(0.0, 0.0);

  final MapType mapType = MapType.Basic;

  final ScrollController cafeListScrollController = ScrollController();

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
    cafeListScrollController.dispose();
    super.dispose();
  }

  void onMapCreated(NaverMapController controller) {
    if (mapController.isCompleted) mapController = Completer();

    CameraUpdate mapCameraArea = CameraUpdate.fitBounds(
      LatLngBounds(
        southwest: LatLng((maxLatitude + minLatitude) / 2, minLongitude),
        northeast: LatLng((maxLatitude + minLatitude) / 2, maxLongitude),
      ),
      padding: 50,
    );

    controller.moveCamera(mapCameraArea);

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

    if (cafeListHeight.value - details.delta.dy < INITCAFELIST_MINIMUM_HEIGHT) {
      cafeListHeight.value = INITCAFELIST_MINIMUM_HEIGHT;
    } else if (cafeListHeight.value - details.delta.dy >
        maximunCafeListHeight) {
      cafeListHeight.value = maximunCafeListHeight;
    } else {
      cafeListHeight.value -= details.delta.dy;
    }

    cafeListScrollController.jumpTo(0);
  }

  void onTapOutCafeList(context) {
    final maximunCafeListHeight = MediaQuery.of(context).size.height - 200.0;

    var changedHeightValue = cafeListHeight.value -
        (cafeListHeightStatus == CafeListHeightType.MAX
            ? maximunCafeListHeight
            : cafeListHeightStatus == CafeListHeightType.MIN
                ? INITCAFELIST_MINIMUM_HEIGHT
                : INITCAFELIST_DEFULT_HEIGHT);

    switch (cafeListHeightStatus.value) {
      case CafeListHeightType.DEFAULT:
        if (changedHeightValue > CAFELIST_CHANGABLE_POINT) {
          cafeListHeightStatus.value = CafeListHeightType.MAX;
          cafeListHeight.value = maximunCafeListHeight;
        } else if (changedHeightValue < -CAFELIST_CHANGABLE_POINT) {
          cafeListHeightStatus.value = CafeListHeightType.MIN;
          cafeListHeight.value = INITCAFELIST_MINIMUM_HEIGHT;
        } else {
          cafeListHeightStatus.value = CafeListHeightType.DEFAULT;
          cafeListHeight.value = INITCAFELIST_DEFULT_HEIGHT;
        }
        break;

      case CafeListHeightType.MIN:
        if (changedHeightValue > CAFELIST_CHANGABLE_POINT) {
          cafeListHeightStatus.value = CafeListHeightType.DEFAULT;
          cafeListHeight.value = INITCAFELIST_DEFULT_HEIGHT;
        } else {
          cafeListHeightStatus.value = CafeListHeightType.MIN;
          cafeListHeight.value = INITCAFELIST_MINIMUM_HEIGHT;
        }
        break;
      case CafeListHeightType.MAX:
        if (changedHeightValue < -CAFELIST_CHANGABLE_POINT) {
          cafeListHeightStatus.value = CafeListHeightType.DEFAULT;
          cafeListHeight.value = INITCAFELIST_DEFULT_HEIGHT;
        } else {
          cafeListHeightStatus.value = CafeListHeightType.MAX;
          cafeListHeight.value = maximunCafeListHeight;
        }
        break;
      default:
        break;
    }
  }

  Future<void> getFavoriteCafeList() async {
    final Storage storage = Storage();
    favoriteCafeIdList.value = await storage.getFavoriteCafe();
  }

  Future<void> _fetchCafeList(int pageKey) async {
    final NadoProvider provider = Get.find<NadoProvider>();
    final Storage storage = Storage();

    try {
      // 사장 목데이터 추가
      CafeTile ceoCafeTile = await storage.getCeoCafeTile();

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

        List<CafeTile> responseCafeTileData =
            searchPagingController.value.nextPageKey == 0 &&
                    selectedCafeType.length == 0
                ? [ceoCafeTile, ...responseInfo.contents]
                : responseInfo.contents;

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

        setMapPointer(newCafeList: responseCafeTileData);
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

        setMapPointer(newCafeList: responseFavoriteCafeTileData);
      }
    } on Exception catch (error) {
      printError(info: "Failed to load favorite cafe infomation");
      searchPagingController.error = error;
    }
  }

  Future<void> setMapPointer({required List<CafeTile> newCafeList}) async {
    isMapLoaded.value = false;

    OverlayImage defaultMarkerIcon = await OverlayImage.fromAssetImage(
      assetName: 'assets/images/marker.png',
    );

    OverlayImage favoriteMarkerIcon = await OverlayImage.fromAssetImage(
      assetName: 'assets/images/favorite_marker.png',
    );

    mapMarkerList.addAll(newCafeList.map(
      (CafeTile cafe) {
        _modifyCameraArea(LatLng(cafe.latitude, cafe.longitude));

        return Marker(
          markerId: 'cafe_${cafe.id}',
          position: LatLng(cafe.latitude, cafe.longitude),
          captionText: '${cafe.cafeName}',
          captionTextSize: 10.0,
          icon: favoriteCafeIdList.contains(cafe.id)
              ? favoriteMarkerIcon
              : defaultMarkerIcon,
          width: 30,
          height: 35,
          onMarkerTab: (marker, iconSize) {
            _onMarkerTap(cafe);
          },
        );
      },
    ).toList());

    isMapLoaded.value = true;
  }

  void _onMarkerTap(CafeTile cafeTileData) {
    Get.dialog(
      AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          contentPadding: EdgeInsets.all(10.0),
          content: Wrap(
            children: [
              CafeListTile(
                cafeTileData: cafeTileData,
                initFavoriteState: cafeTileData.isFavorite ?? false,
              ),
            ],
          )),
    );
  }

  void _modifyCameraArea(LatLng latLng) {
    if (maxLatitude == 0 || maxLatitude < latLng.latitude)
      maxLatitude = latLng.latitude;

    if (minLatitude == 0 || minLatitude > latLng.latitude)
      minLatitude = latLng.latitude;

    if (maxLongitude == 0 || maxLongitude < latLng.longitude)
      maxLongitude = latLng.longitude;

    if (minLongitude == 0 || minLongitude > latLng.longitude)
      minLongitude = latLng.longitude;
  }

  void controlShowFavoriteCafeToggle() async {
    isShowFavoriteCafeList.value = !isShowFavoriteCafeList.value;

    mapMarkerList.clear();

    searchPagingController.refresh();
  }
}
