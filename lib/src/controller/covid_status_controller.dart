import 'package:covid_state_app/src/data/model/covid_status_model.dart';
import 'package:covid_state_app/src/data/repository/covid_status_repository.dart';
import 'package:get/get.dart';

class CovieStatusController extends GetxController {
  final CovieStatusRepository _covieStatusRepository = CovieStatusRepository();
  Rx<Covid19StatisticsModel> covidStatus = Covid19StatisticsModel().obs;

  @override
  void onInit() {
    fetchCovidStatus();
    super.onInit();
  }

  void fetchCovidStatus() async {
    var result = await _covieStatusRepository.fetchCovidStatus();
    covidStatus(result);
  }
}
