import 'package:get/get.dart';
import 'package:nado_client_mvp/app/routes/routes.dart';

class NadoAppBarLogic extends GetxController {
  RxBool isClient = true.obs;

  void onTapUserChangeToggle() {
    isClient.value = !isClient.value;
    Get.offAllNamed(isClient.value ? Routes.CLIENT_PAGE : Routes.CEO_PAGE);
  }
}
