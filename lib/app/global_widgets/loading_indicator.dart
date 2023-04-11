import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  int countUpValue = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 400), (_) {
      setState(() {
        countUpValue += 1;
      });
    });
  }

  @override
  void dispose() {
    if (timer != null) timer!.cancel();
    super.dispose();
  }

  Widget loadingDot({required bool isColor}) {
    return Container(
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        color: isColor ? NadoColor.primary : NadoColor.greyColor[200],
        borderRadius: BorderRadius.circular(100.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/loading_cup.png'),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loadingDot(isColor: countUpValue % 3 == 0),
                SizedBox(width: 17.0),
                loadingDot(isColor: countUpValue % 3 == 1),
                SizedBox(width: 17.0),
                loadingDot(isColor: countUpValue % 3 == 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
