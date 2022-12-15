import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalOrLine extends StatelessWidget {
  const HorizontalOrLine({super.key,
    required this.label,
    required this.color,
    required this.height,
  });

  final String label;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Divider(
              thickness: 1.w,
              color: color,
              height: height,
            )),
      ),
      Text(
        label,
        style: TextStyle(color: color),
      ),
      Expanded(
        child: Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Divider(
              thickness: 1.w,
              color: color,
              height: height,
            )),
      ),
    ]);
  }
}
