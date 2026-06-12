import 'package:flutter/material.dart';
import 'package:quick_job/core/common/widgets/custom_text.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

class UploadedFileCard extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final String fileDate;
  final VoidCallback onRemove;

  const UploadedFileCard({
    super.key,
    required this.fileName,
    required this.fileSize,
    required this.fileDate,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'PDF',
                  style: getTextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text:
                      fileName,
                      fontWeight: FontWeight.w500,fontSize: 12.sp),

                    CustomText(text:
                      '$fileSize ',color: Colors.black54, fontSize: 12,fontWeight: FontWeight.w400),
                  ],
                ),
              ),

            ],
          ),
          SizedBox(height: 20.h,),
          GestureDetector(
            onTap: onRemove,
            child: Row(
              children: [
                Icon(Icons.delete_outline, color: Colors.red),
                SizedBox(width: 4),
                CustomText(text: 'Remove file', color: Colors.red),
              ],
            ),
          ),
        ]

      ),
    );
  }
}
