import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';

import '../../utils/constants/app_colors.dart';

class PageLoader extends StatelessWidget {
  const PageLoader({super.key, this.size});

  final double? size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWave(
        color: AppColors.primary,
        size: size ?? 35.h,
      ),
    );
  }
}
