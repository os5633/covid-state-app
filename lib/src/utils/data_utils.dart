import 'package:intl/intl.dart';

class DataUtils {
  static String numberFormat(double? vlaue) {
    return NumberFormat("###,###,###,###").format(vlaue);
  }
}
