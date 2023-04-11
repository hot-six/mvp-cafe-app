import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/data/provider/storage_provider.dart';
import 'package:nado_client_mvp/app/page/client/logic.dart';
import 'package:nado_client_mvp/app/routes/routes.dart';

class CafeListTileLogic extends GetxController {
  final CafeTile cafeTileData;
  final bool initFavoriteState;

  CafeListTileLogic({
    required this.cafeTileData,
    required this.initFavoriteState,
  });

  late int tileAccuracy;
  late RxBool isFavorite;

  @override
  void onInit() {
    super.onInit();
    if (cafeTileData.isFavorite == null)
      cafeTileData.isFavorite = initFavoriteState;

    isFavorite = cafeTileData.isFavorite!.obs;

    int accuracyIndex = cafeTileData.accuracy ~/ 25;
    tileAccuracy = accuracyIndex < 4 ? accuracyIndex + 1 : accuracyIndex;
  }

  void onTapFavoriteCafeToggle() {
    final Storage storage = Storage();

    if (isFavorite.value == true) {
      storage.deleteFavoriteCafe(cafeId: cafeTileData.id);
    } else {
      storage.addFavoriteCafe(cafeId: cafeTileData.id);
    }

    isFavorite.value = !isFavorite.value;
  }

  void onTapTile() {
    List<String> filterType = [];
    if (Get.isRegistered<ClientPageLogic>()) {
      ClientPageLogic clientLogic = Get.find();

      filterType =
          clientLogic.selectedCafeType.map((type) => type.type).toList();
    }

    Get.toNamed(Routes.CAFE_DETAIL + "/${cafeTileData.id}", arguments: {
      'isFavorite': isFavorite.value,
      'filterTypes': filterType,
      'fromCeoPage': Get.currentRoute.contains('ceo'),
    });
  }
}
