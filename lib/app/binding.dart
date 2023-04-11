import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/cafe.dart';
import 'package:nado_client_mvp/app/data/provider/extensions/base.dart';
import 'package:nado_client_mvp/app/data/provider/storage_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<NadoProvider>(() => NadoProvider(), fenix: true);

    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('isFirstInstall') ?? true) {
      final Storage storage = Storage();

      await storage.saveCeoCafeDetail(cafeData: CafeDetail.full());

      prefs.setBool('isFirstInstall', false);
    }
  }
}
