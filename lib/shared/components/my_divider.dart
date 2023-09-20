import 'package:chat_gpt/shared/style/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key, this.color, this.horizontal, this.vertical});
  final Color? color;
  final double? horizontal;
  final double? vertical;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.symmetric(horizontal: horizontal ?? 0),
      width: double.infinity,
      height: 1.h,
      color: color ?? AppMainColors.greyColor,
    );
  }
}
