import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/data/provider/storage_provider.dart';

class CafeEditPageLogic extends GetxController {
  final PageController pageController = PageController(initialPage: 0);

  late CafeDetail ceoCafeDetail = CafeDetail.empty();
  late CafeTile ceoCafeTile = CafeTile.empty();

  final RxBool isLoaded = false.obs;

  @override
  void onInit() async {
    await _fetchCeoCafeData();
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> _fetchCeoCafeData() async {
    isLoaded.value = false;
    final Storage storage = Storage();

    ceoCafeDetail = await storage.getCeoCafeDetail();
    ceoCafeTile = await storage.getCeoCafeTile();

    await storage.saveCeoCafeTile(cafeData: ceoCafeTile);

    isLoaded.value = true;
  }

  Future<void> saveUpdateData() async {
    final Storage storage = Storage();

    await storage.saveCeoCafeDetail(cafeData: ceoCafeDetail);
    await storage.saveCeoCafeTile(cafeData: ceoCafeTile);
  }
}
