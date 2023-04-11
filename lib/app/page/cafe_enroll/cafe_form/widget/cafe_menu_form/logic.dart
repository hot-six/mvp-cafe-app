import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/menu.dart';

class CafeMenuFormLogic extends GetxController {
  final RxList<Menu> cafeMenuList;

  CafeMenuFormLogic({required this.cafeMenuList});

  void addNewMenu() {
    cafeMenuList.add(Menu(
      name: '',
      price: 0,
      description: '',
    ));
  }
}
