import 'package:get/get.dart';
import 'package:nado_client_mvp/app/routes/routes.dart';
import 'package:nado_client_mvp/app/screens/cafe/view.dart';
import 'package:nado_client_mvp/app/screens/client/view.dart';
import 'package:nado_client_mvp/app/screens/search/view.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.CLIENT_PAGE,
      page: () => ClientPage(),
    ),

    GetPage(
      name: Routes.CLIENT_SEARCH,
      page: () => ClientSearchPage(),
    ),

    GetPage(
      name: Routes.CAFE_DETAIL + '/:id',
      page: () => CafeDetailPage(),
    ),
    // GetPage(name: Routes.CEO_PAGE, page: () => CeoPage(),),
  ];
}
