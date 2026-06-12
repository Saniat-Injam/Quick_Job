import 'package:flutter/material.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

class Avatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final bool hasOnlineDot;

  const Avatar({
    super.key,
    required this.imageUrl,
    this.size = 40,
    this.hasOnlineDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.w,
      height: size.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular((size / 2).r),
            child: Image.asset(
              imageUrl,
              width: size.w,
              height: size.w,
              fit: BoxFit.cover,
            ),
          ),
          if (hasOnlineDot)
            Positioned(
              right: -1.w,
              bottom: -1.h,
              child: Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: Color(0xFF69B22A),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.w),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
