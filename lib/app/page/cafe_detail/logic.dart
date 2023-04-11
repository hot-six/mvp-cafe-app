import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/data/provider/extensions/base.dart';
import 'package:nado_client_mvp/app/data/provider/provider.dart';
import 'package:nado_client_mvp/app/data/provider/storage_provider.dart';
import 'package:nado_client_mvp/app/global_widgets/snackbar.dart';
import 'package:nado_client_mvp/app/page/client/logic.dart';
import 'package:nado_client_mvp/app/page/client/widget/cafe_list_tile/logic.dart';

class CafeDetailPageLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  Completer<NaverMapController> mapController = Completer();
  final ScrollController scrollController = ScrollController();
  final List<String> tabList = ['기본 정보', '메뉴', '위치'];

  late OverlayImage markerIcon;
  late List<String> filterTypes;
  late bool fromCeoPage;

  CafeDetail cafeData = CafeDetail.empty();
  TabController? tabController;

  RxBool expandOpenTimeList = false.obs;
  RxBool isFavorite = false.obs;
  RxInt thumbnailCarouselIndex = 0.obs;

  RxBool isLoaded = false.obs;
  RxBool isAppBarShrink = false.obs;

  @override
  void onInit() async {
    super.onInit();
    markerIcon = await OverlayImage.fromAssetImage(
      assetName: '/assets/images/marker.png',
    );

    tabController = TabController(vsync: this, length: 3);

    String? searchedCafeId = Get.parameters['id'];
    isFavorite.value = Get.arguments['isFavorite'] ?? false;
    filterTypes = Get.arguments['filterTypes'] ?? [];
    fromCeoPage = Get.arguments['fromCeoPage'] ?? true;

    if (fromCeoPage)
      _fetchStoredCafeData();
    else if (searchedCafeId != null)
      await _fetchCafeData(searchedCafeId);
    else {
      NoticeSnackBar.defaultSnackBar(content: '카페정보를 불러올 수 없습니다.');
      Get.back();
    }

    scrollController.addListener(() {
      checkIsShrink();
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(() {
      checkIsShrink();
    });
    scrollController.dispose();
    super.dispose();
  }

  void checkIsShrink() {
    isAppBarShrink.value = scrollController.hasClients &&
        scrollController.offset > (Get.height * 0.6 - 118);
  }

  Future<void> _fetchStoredCafeData() async {
    isLoaded.value = false;
    final Storage storage = Storage();

    cafeData = await storage.getCeoCafeDetail();
    isLoaded.value = true;
  }

  Future<void> _fetchCafeData(String cafeId) async {
    final NadoProvider provider = Get.find<NadoProvider>();

    isLoaded.value = false;
    try {
      var response = await provider.getCafeDetailData(
        cafeId: cafeId,
        filterTypes: filterTypes,
      );

      if (response.isOk && response.body != null) {
        cafeData = response.body!;
      } else {
        printError(info: 'Failed to get cafe detail information.');
        cafeData = CafeDetail.empty();
      }
    } on Exception catch (error) {
      error.printError();
      cafeData = CafeDetail.empty();
    }

    isLoaded.value = true;
  }

  void toggleFavoriteCafe() async {
    final Storage storage = Storage();

    if (isFavorite.value == true) {
      storage.deleteFavoriteCafe(cafeId: cafeData.id);
      NoticeSnackBar.defaultSnackBar(content: '관심 카페 목록에서 삭제했어요.');
    } else {
      storage.addFavoriteCafe(cafeId: cafeData.id);
      NoticeSnackBar.defaultSnackBar(content: '관심 카페 목록에 추가했어요.');
    }

    if (Get.isRegistered<CafeListTileLogic>(tag: 'cafe_tile_${cafeData.id}')) {
      CafeListTileLogic cafeTileLogic =
          Get.find<CafeListTileLogic>(tag: 'cafe_tile_${cafeData.id}');

      cafeTileLogic.onTapFavoriteCafeToggle();
    }

    if (Get.isRegistered<ClientPageLogic>()) {
      ClientPageLogic clientPageLogic = Get.find<ClientPageLogic>();

      clientPageLogic.refresh();
    }

    isFavorite.value = !isFavorite.value;
  }

  void copyAddress() async {
    Clipboard.setData(ClipboardData(text: cafeData.cafeAddress));
    NoticeSnackBar.defaultSnackBar(content: '주소를 복사했습니다.');
  }
}
