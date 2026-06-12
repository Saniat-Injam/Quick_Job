import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final String? iconPath;
  final double? iconSize;
  final Color borderColor;
  final Function(String?)? onFieldSubmitted;
  final VoidCallback? onclick;
  final IconData? susfixIcon;

  const CustomSearchBar({
    super.key,
    this.susfixIcon,
    this.onclick,
    this.hintText = "Search...",
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.borderRadius = 12,
    this.contentPadding,
    this.iconPath,
    this.iconSize,
    this.borderColor = const Color(0xffD1D6DB),
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      readOnly: readOnly,
      style: getTextStyle(
        color: AppColors.black3,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: getTextStyle(
          color: AppColors.black4,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: GestureDetector(
            onTap: onclick,
            child: susfixIcon != null
                ? Icon(susfixIcon)
                : SvgPicture.asset(
                    iconPath ?? IconPath.searchBarSearch,
                    width: iconSize ?? 20.w,
                    height: iconSize ?? 20.h,
                  ),
          ),
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: iconSize ?? 20.w,
          minHeight: iconSize ?? 20.h,
        ),
        filled: true,
        fillColor: AppColors.whitePrimary,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),

        // ✅ Proper border definitions
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          borderSide: BorderSide(color: AppColors.searchBardBorder, width: 1.5),
        ),
      ),
    );
  }
}
