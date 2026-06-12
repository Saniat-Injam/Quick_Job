import 'package:flutter/material.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Color(0xFFD1D6DB), width: 1.w),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Search...',
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xFF2C3E50),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Transform.rotate(
            angle: 1.57,
            child: Icon(Icons.search, size: 18.w, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
