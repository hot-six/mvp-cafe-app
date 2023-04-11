import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';
import 'package:nado_client_mvp/app/page/faq/logic.dart';
import 'package:nado_client_mvp/app/routes/routes.dart';

class FAQPage extends StatelessWidget {
  final FAQPageLogic logic = Get.put(FAQPageLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('문의하기'),
      ),
      body: Container(
        color: NadoColor.greyColor[100],
        padding: EdgeInsets.symmetric(horizontal: 26.0, vertical: 24.0),
        child: Column(
          children: [
            faqTile(
              title: '피드백 제공',
              subtitle: '카페에 대한 피드백이 있으신가요?',
              faqRoute: Routes.FAQ_FEEDBACK,
            ),
            SizedBox(
              height: 13.0,
            ),
            faqTile(
                title: '서비스 추가 희망 지역',
                subtitle: '희망하는 지역이 있으신가요?',
                faqRoute: Routes.FAQ_REGION),
          ],
        ),
      ),
    );
  }

  Widget faqTile({
    required String title,
    required String subtitle,
    required String faqRoute,
  }) {
    return InkWell(
      onTap: () {
        Get.toNamed(faqRoute);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: NadoColor.primary,
          borderRadius: BorderRadius.circular(11.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 18.0),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 5.0),
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset('assets/images/circle_arrow.png'),
            )
          ],
        ),
      ),
    );
  }
}
