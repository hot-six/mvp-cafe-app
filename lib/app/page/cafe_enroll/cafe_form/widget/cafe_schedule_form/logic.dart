import 'package:get/get.dart';
import 'package:nado_client_mvp/app/data/model/schedule.dart';

class CafeScheduleFormLogic extends GetxController {
  final List<CafeSchedule> cafeSchedule;

  final RxBool isCafeOpenTimeEqual = true.obs;

  CafeScheduleFormLogic({required this.cafeSchedule});
}
