import 'package:get/get.dart';
import 'package:nado_client_mvp/app/page/faq/view.dart';
import 'package:nado_client_mvp/app/page/faq_detail/faq_feedback/view.dart';
import 'package:nado_client_mvp/app/page/faq_detail/faq_region/view.dart';
import 'package:nado_client_mvp/app/routes/routes.dart';
import 'package:nado_client_mvp/app/page/cafe_detail/view.dart';
import 'package:nado_client_mvp/app/page/cafe_edit/view.dart';
import 'package:nado_client_mvp/app/page/ceo/view.dart';
import 'package:nado_client_mvp/app/page/client/view.dart';
import 'package:nado_client_mvp/app/page/search/view.dart';

class AppPages {
  static final pages = [
    //Client Pages
    GetPage(
      name: Routes.CLIENT_PAGE,
      page: () => ClientPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.CLIENT_SEARCH,
      page: () => ClientSearchPage(),
    ),
    GetPage(
      name: Routes.CAFE_DETAIL + '/:id',
      page: () => CafeDetailPage(),
    ),

    //CEO Pages
    GetPage(
      name: Routes.CEO_PAGE,
      page: () => CeoPage(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.CEO_EDIT,
      page: () => CafeEditPage(),
    ),

    //FAQ
    GetPage(
      name: Routes.FAQ,
      page: () => FAQPage(),
    ),
    GetPage(
      name: Routes.FAQ_FEEDBACK,
      page: () => FAQFeedBackPage(),
    ),
    GetPage(
      name: Routes.FAQ_REGION,
      page: () => FAQRegionPage(),
    ),
  ];
}
