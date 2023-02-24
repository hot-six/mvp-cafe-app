import 'package:intl/intl.dart';

String displayIntegerPrice(int? price) {
  if (price == null) return '-';

  var formatter = NumberFormat.currency(locale: 'ko_KR', symbol: '');
  return '${formatter.format(price)} 원';
}
