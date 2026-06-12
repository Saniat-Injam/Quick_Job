import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/features/navbar/controllers/navbar_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NavBarController>();

    return Obx(
      () => Container(
        height: 108.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Color(0xffA7A6A5).withValues(alpha: 1.2),
              blurRadius: 4,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.whitePrimary,
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeIndex,
            selectedItemColor: AppColors.bluePrimary,
            unselectedItemColor: AppColors.black4,
            // Style the labels
            selectedLabelStyle: getTextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.bluePrimary,
            ),
            unselectedLabelStyle: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
              color: AppColors.black4,
            ),

            items: controller.navItems.map((item) {
              int index = controller.navItems.indexOf(item);
              bool isSelected = controller.selectedIndex.value == index;
              return BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  item.iconPath,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    isSelected ? AppColors.bluePrimary : AppColors.black4,
                    BlendMode.srcIn,
                  ),
                ),
                label: item.label,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
