import 'package:covid_state_app/src/controller/covid_status_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CovidAppHome extends GetView<CovieStatusController> {
  const CovidAppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("코로나 일별 현황"),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
