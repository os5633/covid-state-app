import 'package:intl/intl.dart';

class DataUtils {
  static String numberFormat(double? vlaue) {
    return NumberFormat("###,###,###,###").format(vlaue);
  }

  static String simpleDayFormat(DateTime time) {
    return DateFormat('MM.dd').format(time);
  }
}
