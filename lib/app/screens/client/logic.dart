import 'dart:async';

import 'package:get/get.dart';
import 'package:nado_client_mvp/app/screens/search/view.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

const double INITCAFELISTHEIGHT = 300.0;

class ClientPageLogic extends GetxController {
  final RxDouble cafeListHeight = INITCAFELISTHEIGHT.obs;
  RxList<String> selectedCafeType = <String>[].obs;

  final MapType mapType = MapType.Basic;
  Completer<NaverMapController> mapController = Completer();

  void onMapCreated(NaverMapController controller) {
    if (mapController.isCompleted) mapController = Completer();
    mapController.complete(controller);
  }

  void onTapSearchButton() async {
    selectedCafeType.value =
        await Get.to(ClientSearchPage(), arguments: selectedCafeType) ?? [];
  }

  void onChangeCafeListHeight({required double changedHeight}) {
    cafeListHeight.value =
        changedHeight > INITCAFELISTHEIGHT ? changedHeight : INITCAFELISTHEIGHT;
  }
}
