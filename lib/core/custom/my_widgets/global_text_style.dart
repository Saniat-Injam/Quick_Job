import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';

// TextStyle getTextStyle({
//   double fontSize = 14.0,
//   FontWeight fontWeight = FontWeight.w400,
//   double lineHeight = 21.0,
//   TextAlign textAlign = TextAlign.center,
//   Color color = Colors.black,
// }) {
//   return GoogleFonts.poppins(
//     fontSize: fontSize.sp,
//     fontWeight: fontWeight,
//     height: fontSize.sp / lineHeight.sp,
//     color: color,
//   );
// }

TextStyle getTextStyle({
  double? fontSize,
  FontWeight? fontWeight,
  double? height,
  TextAlign? textAlign,
  Color? color,
  int? maxLines,
  TextOverflow? textOverflow,
  TextDecoration? decoration,
  double? decorationThickness,
  Color? decorationColor,
}) {
  return GoogleFonts.inter(
    fontSize: fontSize ?? getWidth(14),
    fontWeight: fontWeight ?? FontWeight.w600,
    //height: lineHeight != null ? (lineHeight / fontSize!) : 1.3,
    height: height ?? 1.3,
    color: color ?? AppColors.textPrimary,
    decoration: decoration,
    decorationThickness: decorationThickness,
    decorationColor: decorationColor ?? const Color(0xff2972FF),
  );
}
