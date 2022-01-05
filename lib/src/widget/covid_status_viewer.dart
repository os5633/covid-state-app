import 'package:covid_state_app/src/canvas/arrow_clip_path.dart';
import 'package:covid_state_app/src/utils/data_utils.dart';
import 'package:flutter/material.dart';

class CovidStatusViewer extends StatelessWidget {
  const CovidStatusViewer({
    Key? key,
    required this.title,
    required this.addedCount,
    required this.upDwon,
    required this.totalCount,
    this.dense = true,
    this.titleColor = const Color(0xff4c4e5d),
    this.vlaueColor = Colors.black,
    this.spacing = 10,
  }) : super(key: key);

  final String title;
  final double addedCount;
  final ArrowDirection upDwon;
  final double totalCount;
  final bool dense;
  final Color titleColor;
  final Color vlaueColor;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    Color upDownColor = Colors.black;
    switch (upDwon) {
      case ArrowDirection.up:
        upDownColor = const Color(0xffff1c03);
        break;
      case ArrowDirection.middle:
        upDownColor = Colors.grey;
        break;
      case ArrowDirection.down:
        upDownColor = Colors.blue[700]!;
        break;
    }
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(color: titleColor, fontSize: dense ? 14 : 18),
        ),
        SizedBox(
          height: spacing,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipPath(
              clipper: ArrowClipPath(direction: upDwon),
              child: Container(
                width: dense ? 10 : 20,
                height: dense ? 10 : 20,
                color: upDownColor,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              DataUtils.numberFormat(addedCount),
              style: TextStyle(
                  color: upDownColor,
                  fontSize: dense ? 25 : 50,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          DataUtils.numberFormat(totalCount),
          style: TextStyle(
            color: vlaueColor,
            fontSize: dense ? 15 : 20,
          ),
        ),
      ],
    );
  }
}
