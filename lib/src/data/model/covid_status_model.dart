import 'package:covid_state_app/src/utils/xml_utils.dart';
import 'package:xml/xml.dart';

class CovidStatusModel {
  double? accExamCnt;
  double? deathCnt;
  double? decideCnt;
  double clacAccExamCnt = 0;
  double calcDeathCnt = 0;
  double calcDecideCnt = 0;
  double? seq;
  DateTime? stateDt;
  String? createDt;
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

  factory CovidStatusModel.empty() {
    return CovidStatusModel();
  }

  factory CovidStatusModel.fromXml(XmlElement xml) {
    return CovidStatusModel(
      accExamCnt: XmlUtils.searchResultForDouble(xml, 'accExamCnt'),
      createDt: XmlUtils.searchResultForString(xml, 'createDt'),
      deathCnt: XmlUtils.searchResultForDouble(xml, 'deathCnt'),
      decideCnt: XmlUtils.searchResultForDouble(xml, 'decideCnt'),
      seq: XmlUtils.searchResultForDouble(xml, 'seq'),
      stateDt: XmlUtils.searchResultForString(xml, 'stateDt') != ''
          ? DateTime.parse(XmlUtils.searchResultForString(xml, 'stateDt'))
          : null,
      stateTime: XmlUtils.searchResultForString(xml, 'stateTime'),
      updateDt: XmlUtils.searchResultForString(xml, 'updateDt'),
    );
  }
  void updateCalcAboutYesterday(CovidStatusModel yesterDayData) {
    _updateCalcDecideCnt(yesterDayData.decideCnt!);
    _updateCalcDeathCnt(yesterDayData.deathCnt!);
    _updateClacAccExamCnt(yesterDayData.accExamCnt!);
  }

  void _updateCalcDecideCnt(double beforeCnt) {
    calcDecideCnt = decideCnt! - beforeCnt;
  }

  void _updateClacAccExamCnt(double beforeCnt) {
    clacAccExamCnt = accExamCnt! - beforeCnt;
  }

  void _updateCalcDeathCnt(double beforeCnt) {
    calcDeathCnt = deathCnt! - beforeCnt;
  }
}
