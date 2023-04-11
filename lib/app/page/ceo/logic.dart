import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/data/provider/storage_provider.dart';
import 'package:nado_client_mvp/app/global_widgets/dialog/ceo_dialog.dart';

class CeoPageLogic extends GetxController {
  Completer<NaverMapController> mapController = Completer();

  late CafeDetail ceoCafeDetail;
  late CafeTile ceoCafeTile;

  final RxList<Marker> mapMarkerList = <Marker>[].obs;

  final RxBool isLoaded = false.obs;

  @override
  void onInit() async {
    super.onInit();

    isLoaded.value = false;
    await _initCafeData();
    await _setMapPointer();
    isLoaded.value = true;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.dialog(CeoNoticeInfoDialog());
    });
  }

  Future<void> _initCafeData() async {
    final Storage storage = Storage();

    ceoCafeDetail = await storage.getCeoCafeDetail();
    ceoCafeTile = await storage.getCeoCafeTile();
  }

  Future<void> _setMapPointer() async {
    OverlayImage markerIcon = await OverlayImage.fromAssetImage(
      assetName: 'assets/images/marker.png',
    );

    mapMarkerList.add(Marker(
      markerId: 'ceo_cafe',
      position: LatLng(ceoCafeDetail.latitude, ceoCafeDetail.longitude),
      captionText: '${ceoCafeDetail.cafeName}',
      captionTextSize: 10.0,
      icon: markerIcon,
      width: 30,
      height: 35,
    ));
  }

  void onMapCreated(NaverMapController controller) {
    if (mapController.isCompleted) mapController = Completer();
    mapController.complete(controller);
  }
}
