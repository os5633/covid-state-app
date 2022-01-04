import 'package:flutter/material.dart';

class CovidAppHome extends StatelessWidget {
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
