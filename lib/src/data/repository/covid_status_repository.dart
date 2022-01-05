import 'package:covid_state_app/src/constant.dart';
import 'package:covid_state_app/src/data/model/covid_status_model.dart';
import 'package:dio/dio.dart';
import 'package:xml/xml.dart';

class CovieStatusRepository {
  final _dio = Dio(
    BaseOptions(
      baseUrl: "http://openapi.data.go.kr",
      queryParameters: {
        "ServiceKey": apiKey,
      },
    ),
  );
  final bookshelfXml =
      '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<response>
    <header>
        <resultCode>00</resultCode>
        <resultMsg>NORMAL SERVICE.</resultMsg>
    </header>
    <body>
        <items>
            <item>
                <accExamCnt>19671880</accExamCnt>
                <createDt>2022-01-04 09:04:35.476</createDt>
                <deathCnt>5781</deathCnt>
                <decideCnt>645225</decideCnt>
                <seq>748</seq>
                <stateDt>20220104</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2022-01-05 09:02:33.695</updateDt>
            </item>
            <item>
                <accExamCnt>19546883</accExamCnt>
                <createDt>2022-01-03 08:58:35.591</createDt>
                <deathCnt>5730</deathCnt>
                <decideCnt>642201</decideCnt>
                <seq>747</seq>
                <stateDt>20220103</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2022-01-05 09:02:25.442</updateDt>
            </item>
            <item>
                <accExamCnt>19456900</accExamCnt>
                <createDt>2022-01-02 08:57:24.688</createDt>
                <deathCnt>5694</deathCnt>
                <decideCnt>639076</decideCnt>
                <seq>746</seq>
                <stateDt>20220102</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2022-01-04 09:06:25.335</updateDt>
            </item>
            <item>
                <accExamCnt>19364122</accExamCnt>
                <createDt>2022-01-01 09:02:39.218</createDt>
                <deathCnt>5625</deathCnt>
                <decideCnt>635244</decideCnt>
                <seq>745</seq>
                <stateDt>20220101</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2022-01-04 09:06:17.135</updateDt>
            </item>
            <item>
                <accExamCnt>19309072</accExamCnt>
                <createDt>2021-12-31 09:04:09.35</createDt>
                <deathCnt>5563</deathCnt>
                <decideCnt>630829</decideCnt>
                <seq>744</seq>
                <stateDt>20211231</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2022-01-04 09:06:08.197</updateDt>
            </item>
            <item>
                <accExamCnt>19251165</accExamCnt>
                <createDt>2021-12-30 09:06:07.06</createDt>
                <deathCnt>5455</deathCnt>
                <decideCnt>625955</decideCnt>
                <seq>743</seq>
                <stateDt>20211230</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2022-01-04 09:05:54.411</updateDt>
            </item>
            <item>
                <accExamCnt>19196738</accExamCnt>
                <createDt>2021-12-29 08:56:22.982</createDt>
                <deathCnt>5382</deathCnt>
                <decideCnt>620921</decideCnt>
                <seq>742</seq>
                <stateDt>20211229</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2022-01-04 09:05:44.529</updateDt>
            </item>
            <item>
                <accExamCnt>19141481</accExamCnt>
                <createDt>2021-12-28 09:01:15.646</createDt>
                <deathCnt>5346</deathCnt>
                <decideCnt>615514</decideCnt>
                <seq>741</seq>
                <stateDt>20211228</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2022-01-04 09:05:38.235</updateDt>
            </item>
        </items>
        <numOfRows>10</numOfRows>
        <pageNo>1</pageNo>
        <totalCount>8</totalCount>
    </body>
</response>''';

  Future<CovidStatusModel> fetchCovidStatus() async {
    dynamic response =
        await _dio.get('/openapi/service/rest/Covid19/getCovid19InfStateJson');
    final document = XmlDocument.parse(response.data);
    final results = document.findAllElements('item');

    if (results.isNotEmpty) {
      return CovidStatusModel.fromXml(results.first);
    }

    return Future.value(null);
  }
}
