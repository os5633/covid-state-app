import 'package:covid_state_app/src/constant.dart';
import 'package:covid_state_app/src/data/model/covid_status_model.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class CovieStatusRepository {
  var _dio;

  CovieStatusRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://openapi.data.go.kr",
        queryParameters: {
          "ServiceKey": apiKey,
        },
      ),
    );
  }

  Future<Covid19StatisticsModel> fetchCovidStatus() async {
    var response =
        await _dio.get('/openapi/service/rest/Covid19/getCovid19InfStateJson');
    final document = XmlDocument.parse(response.data);
    final results = document.findAllElements('item');

    if (results.isNotEmpty) {
      return Covid19StatisticsModel.fromXml(results.first);
    } else {
      return Future.value(null);
    }
  }
}
