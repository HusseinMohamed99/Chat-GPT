import 'package:flutter/material.dart';

Widget defaultButton({
  required Function()? function,
  required Widget widget,
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
  required BuildContext context,
}) {
  return MaterialButton(
    color: color,
    onPressed: function,
    child: widget,
  );
}
