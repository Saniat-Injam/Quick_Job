import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onVisibilityToggle;
  final String? prefixSvg;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final bool isRequired;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon; // Add this field for custom suffix icon
  final int? maxLine;

  const CustomInputField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.isPassword = false,
    this.obscureText = false,
    this.onVisibilityToggle,
    this.prefixSvg,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.isRequired = false,
    this.readOnly = false,
    this.onTap,
    this.maxLine,
    this.suffixIcon, // Include suffixIcon here
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label with optional asterisk
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: getTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black3,
                ),
              ),
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 8.h),

        /// TextField
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            maxLines: maxLine ?? 1,
            validator: validator,
            controller: controller,
            onChanged: onChanged,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboardType,
            obscureText: obscureText,
            readOnly: readOnly,
            onTap: onTap,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.blackSecondary,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: getTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black4,
              ),

              /// Prefix Icon (SVG)
              prefixIcon: prefixSvg != null
                  ? Padding(
                      padding: EdgeInsets.all(12.w),
                      child: SvgPicture.asset(
                        prefixSvg!,
                        width: 20.w,
                        height: 20.h,
                      ),
                    )
                  : null,

              /// Password toggle
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xFF757575),
                        size: 22.sp,
                      ),
                      onPressed: onVisibilityToggle,
                    )
                  : null,

              filled: true,
              fillColor: readOnly ? const Color(0xFFF9FAFB) : Colors.white,

              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 12.h,
              ),
              errorStyle: GoogleFonts.inter(fontSize: 10.sp),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(
                  color: Color(0xFF0E55FD),
                  width: 1.2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
