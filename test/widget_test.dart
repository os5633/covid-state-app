import 'package:flutter_test/flutter_test.dart';
import 'package:xml/xml.dart';

void main() {
  const bookshelfXml =
      '''<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<response>
    <header>
        <resultCode>00</resultCode>
        <resultMsg>NORMAL SERVICE.</resultMsg>
    </header>
    <body>
        <items>
            <item>
                <accExamCnt>19546883</accExamCnt>
                <createDt>2022-01-03 08:58:35.591</createDt>
                <deathCnt>5730</deathCnt>
                <decideCnt>642202</decideCnt>
                <seq>747</seq>
                <stateDt>20220103</stateDt>
                <stateTime>00:00</stateTime>
                <updateDt>2022-01-04 09:06:34.776</updateDt>
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
        </items>
        <numOfRows>10</numOfRows>
        <pageNo>1</pageNo>
        <totalCount>2</totalCount>
    </body>
</response>''';

  test('코로나 전체 통계', () {
    final document = XmlDocument.parse(bookshelfXml);
    final items = document.findAllElements('item');
    var covid19Statics = <CovidStatusModel>[];
    for (var node in items) {
      covid19Statics.add(CovidStatusModel.fromXml(node));
    }
    for (var covid19 in covid19Statics) {
      print('${covid19.stateDt} : ${covid19.decideCnt}');
    }
  });
}

class CovidStatusModel {
  String? accExamCnt;
  String? createDt;
  String? deathCnt;
  String? decideCnt;
  String? seq;
  String? stateDt;
  String? stateTime;
  String? updateDt;
  CovidStatusModel({
    this.accExamCnt,
    this.createDt,
    this.deathCnt,
    this.decideCnt,
    this.seq,
    this.stateDt,
    this.stateTime,
    this.updateDt,
  });

  factory CovidStatusModel.fromXml(XmlElement xml) {
    return CovidStatusModel(
      accExamCnt: XmlUtils.searchResult(xml, 'accDefRate'),
      createDt: XmlUtils.searchResult(xml, 'createDt'),
      deathCnt: XmlUtils.searchResult(xml, 'deathCnt'),
      decideCnt: XmlUtils.searchResult(xml, 'decideCnt'),
      seq: XmlUtils.searchResult(xml, 'seq'),
      stateDt: XmlUtils.searchResult(xml, 'stateDt'),
      stateTime: XmlUtils.searchResult(xml, 'stateTime'),
      updateDt: XmlUtils.searchResult(xml, 'updateDt'),
    );
  }
}

class XmlUtils {
  static String searchResult(XmlElement xml, String key) {
    return xml.findAllElements(key).map((e) => e.text).isEmpty
        ? ""
        : xml.findAllElements(key).map((e) => e.text).first;
  }
}
