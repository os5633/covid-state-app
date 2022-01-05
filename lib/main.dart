import 'package:covid_state_app/src/controller/covid_status_controller.dart';
import 'package:covid_state_app/src/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: CovidAppHome(),
      initialBinding: BindingsBuilder(() {
        Get.put(CovieStatusController());
      }),
    );
  }
}
