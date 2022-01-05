import 'package:covid_state_app/src/canvas/arrow_clip_path.dart';
import 'package:covid_state_app/src/data/model/covid_status_model.dart';
import 'package:covid_state_app/src/data/repository/covid_status_repository.dart';
import 'package:covid_state_app/src/utils/data_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CovieStatusController extends GetxController {
  final CovieStatusRepository _covieStatusRepository = CovieStatusRepository();
  final Rx<CovidStatusModel> _todayData = CovidStatusModel().obs;
  final RxList<CovidStatusModel> _weekDatas = <CovidStatusModel>[].obs;
  double maxDecideValue = 0;
  @override
  void onInit() {
    fetchCovidStatus();
    super.onInit();
  }

  void fetchCovidStatus() async {
    String startDate = DateFormat('yyyyMMdd')
        .format(DateTime.now().subtract(const Duration(days: 7)));
    String endDate = DateFormat('yyyyMMdd').format(DateTime.now());
    List<CovidStatusModel> result = await _covieStatusRepository
        .fetchCovidStatus(startDate: startDate, endDate: endDate);
    if (result.isNotEmpty) {
      for (int i = 0; i < result.length; i++) {
        if (i < result.length - 1) {
          result[i].updateCalcAboutYesterday(result[i + 1]);
          if (maxDecideValue < result[i].calcDecideCnt) {
            maxDecideValue = result[i].calcDecideCnt;
          }
        }
      }
      _weekDatas.addAll(result.sublist(0, result.length - 1).reversed);
      _todayData(_weekDatas.last);
    }
  }

  CovidStatusModel get todayDate => _todayData.value;
  List<CovidStatusModel> get weekDatas => _weekDatas;
  String get standardDayString => _todayData.value.stateDt == null
      ? ''
      : '${DataUtils.simpleDayFormat(_todayData.value.stateDt!)} ${_todayData.value.stateTime} 기준';

  ArrowDirection calculrateUpDown(double value) {
    if (value == 0) {
      return ArrowDirection.middle;
    } else if (value > 0) {
      return ArrowDirection.up;
    } else {
      return ArrowDirection.down;
    }
  }
}
