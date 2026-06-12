import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

class ChatInput extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String) onSend;

  const ChatInput({super.key, this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    final textController = controller ?? TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // IconButton(
          //   icon: Icon(Icons.emoji_emotions_outlined, color: AppColors.grey4),
          //   onPressed: () {
          //     // Handle emoji picker
          //   },
          // ),
          // SizedBox(width: 8.w),
          Expanded(
            child: TextFormField(
              onFieldSubmitted: (_) {
                log(textController.text);
                if (textController.text.isNotEmpty) {
                  onSend(textController.text);
                }
              },
              controller: textController,
              style: GoogleFonts.inter(),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: GoogleFonts.inter(),
                labelStyle: GoogleFonts.inter(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: AppColors.grey4.withValues(alpha: 0.3),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: AppColors.grey4.withValues(alpha: 0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
              maxLines: 1,
              textInputAction: TextInputAction.send,
              // onSubmitted: (value) {
              //   if (value.trim().isNotEmpty) {
              //     onSend(value);
              //   }
              // },
            ),
          ),

          SizedBox(width: 8.w),

          // Send button
          Material(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(24),
            child: InkWell(
              onTap: () {
                final text = textController.text;
                if (text.trim().isNotEmpty) {
                  onSend(text);
                }
              },
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: EdgeInsets.all(12.w),
                child: Icon(Icons.send, color: Colors.white, size: 20.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
