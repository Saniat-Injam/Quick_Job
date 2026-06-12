import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/app_sizes.dart';

class CustomDottetContiner extends StatelessWidget {
  const CustomDottetContiner({
    super.key,
    this.text,
    this.onTap,
    this.continerHeight,
    this.top,
  });

  final String? text;
  final VoidCallback? onTap;
  final double? continerHeight;
  final bool? top;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          dashPattern: [4, 3],
          strokeWidth: 1,
          color: AppColors.bluePrimary,
          padding: continerHeight != null
              ? EdgeInsets.only(
                  top: getHeight((top ?? false) ? 16 : continerHeight!),
                  bottom: getHeight(continerHeight!),
                  left: getWidth(16),
                  right: getWidth(16),
                )
              : EdgeInsets.all(getHeight(16)),
          radius: Radius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(getHeight(4)),
              decoration: BoxDecoration(
                color: AppColors.bluePrimary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                size: 14.sp,
                color: AppColors.whitePrimary,
              ),
            ),
            if ((text ?? "").isNotEmpty) ...[
              SizedBox(width: getWidth(5)),
              CustomText(
                text: text ?? "",
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.bluePrimary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
