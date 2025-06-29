import 'package:flutter/material.dart';
import 'package:lead_manager/core/utils/app_colors.dart';

Widget textWidget(String text,
    {Color? color, double? fontSize, FontWeight? fontWeight}) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 16,
      color: color ?? AppColors.black,
    ),
  );
}
