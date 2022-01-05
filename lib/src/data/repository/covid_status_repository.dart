import 'package:covid_state_app/src/constant.dart';
import 'package:covid_state_app/src/data/model/covid_status_model.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class CovieStatusRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://openapi.data.go.kr",
      queryParameters: {'ServiceKey': apiKey},
    ),
  );

  Future<List<CovidStatusModel>> fetchCovidStatus(
      {String? startDate, String? endDate}) async {
    Map<String, String> query = <String, String>{};
    if (startDate != null) query.putIfAbsent('startCreateDt', () => startDate);
    if (endDate != null) query.putIfAbsent('endCreateDt', () => endDate);
    dynamic response = await _dio.get(
        '/openapi/service/rest/Covid19/getCovid19InfStateJson',
        queryParameters: query);
    final document = XmlDocument.parse(response.data);
    final results = document.findAllElements('item');

    return results
        .map<CovidStatusModel>((element) => CovidStatusModel.fromXml(element))
        .toList();
  }
}
