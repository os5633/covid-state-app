import 'package:covid_state_app/src/controller/covid_status_controller.dart';
import 'package:covid_state_app/src/widget/bar_chart.dart';
import 'package:covid_state_app/src/widget/covid_status_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CovidAppHome extends GetView<CovieStatusController> {
  CovidAppHome({Key? key}) : super(key: key);
  double headerTopZone = 0;
  List<Widget> _background(hedaerTopZone) => [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                Colors.red.shade400,
                Colors.blue.shade400,
              ],
            ),
          ),
        ),
        Positioned(
          left: -110,
          top: hedaerTopZone,
          child: Image.asset(
            "assets/covid_icon.png",
            width: Get.width * 0.8,
          ),
        ),
        Positioned(
          top: hedaerTopZone + 10,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: Colors.red),
              child: Obx(
                () => Text(
                  controller.standardDayString,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: hedaerTopZone + 60,
          right: 40,
          child: Obx(() => CovidStatusViewer(
                title: "확진자",
                titleColor: Colors.white,
                addedCount: controller.todayDate.calcDecideCnt,
                totalCount: controller.todayDate.decideCnt ?? 0,
                upDown: controller
                    .calculrateUpDown(controller.todayDate.calcDecideCnt),
                vlaueColor: Colors.white,
                spacing: 0,
                dense: false,
              )),
        )
      ];

  @override
  Widget build(BuildContext context) {
    headerTopZone = Get.mediaQuery.padding.top + AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("코로나 일별 현황"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Stack(
        children: [
          ..._background(headerTopZone),
          Positioned(
            top: headerTopZone + 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(38),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _todaySatus(),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "확진자 추이",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Obx(
                          () => controller.weekDatas.isEmpty
                              ? Container()
                              : CovidBarChart(
                                  covidDatas: controller.weekDatas,
                                  maxY: controller.maxDecideValue,
                                ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Row _todaySatus() {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => CovidStatusViewer(
              title: "검사 수",
              addedCount: controller.todayDate.clacAccExamCnt,
              totalCount: controller.todayDate.accExamCnt ?? 0,
              upDown: controller
                  .calculrateUpDown(controller.todayDate.clacAccExamCnt),
            ),
          ),
        ),
        Container(
          height: 60,
          width: 1,
          color: Colors.grey[200],
        ),
        Expanded(
            child: Obx(
          () => CovidStatusViewer(
            title: "사망자",
            addedCount: controller.todayDate.calcDeathCnt,
            totalCount: controller.todayDate.deathCnt ?? 0,
            upDown:
                controller.calculrateUpDown(controller.todayDate.calcDeathCnt),
          ),
        )),
      ],
    );
  }
}
