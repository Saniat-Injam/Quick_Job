// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
// import 'package:quick_job/core/utils/constants/app_colors.dart';
// import 'package:quick_job/core/utils/constants/app_sizer.dart';
// import 'package:quick_job/core/utils/constants/image_path.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final double? height;
//   final double? margin;
//   final String? title;
//   final TextStyle? textStyle;
//   final String? iconPath;
//   final VoidCallback? onTap;
//   final EdgeInsetsGeometry? padding;
//   final Color? borderColor;
//   final double? spacing;
//   final Color? backgroundColor;
//   // 🔹 Leading image path (network, file, or asset)
//   final String? leadingImagePath;
//   final String? trailingIconPath;
//   final VoidCallback? onTrailingTap;

//   // 🔹 New property to control title alignment
//   final bool centerTitle;

//   const CustomAppBar({
//     super.key,
//     this.height,
//     this.margin,
//     this.title,
//     this.textStyle,
//     this.iconPath,
//     this.onTap,
//     this.padding,
//     this.borderColor,
//     this.spacing = 0,
//     this.backgroundColor,
//     this.leadingImagePath, // flexible leading image
//     this.trailingIconPath,
//     this.onTrailingTap,
//     this.centerTitle = false,
//   });
//   @override
//   Size get preferredSize => Size.fromHeight(height?.h ?? 60.h);

//   Widget _buildLeadingImage(String path) {
//     if (path.startsWith('http')) {
//       return CircleAvatar(
//         radius: 24,
//         backgroundColor: Colors.grey[200],
//         child: ClipOval(
//           child: CachedNetworkImage(
//             imageUrl: path,
//             width: 48,
//             height: 48,
//             fit: BoxFit.cover,
//             placeholder: (context, url) =>
//                 CircularProgressIndicator(strokeWidth: 2),
//             errorWidget: (context, url, error) => Icon(Icons.person),
//           ),
//         ),
//       );
//     } else if (File(path).existsSync()) {
//       return CircleAvatar(radius: 24, backgroundImage: FileImage(File(path)));
//     } else {
//       return CircleAvatar(radius: 24, backgroundImage: AssetImage(path));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height?.h ?? 60.h,
//       padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
//       margin: margin != null ? EdgeInsets.only(top: margin!.h) : null,
//       decoration: BoxDecoration(
//         color: backgroundColor ?? AppColors.whitePrimary,
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0x1FA7A6A5),
//             offset: const Offset(-8, 0),
//             blurRadius: 22,
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Row(
//             children: [
//               SizedBox(width: spacing?.w),

//               // 🔹 Leading image or back button
//               if (leadingImagePath != null)
//                 SizedBox(
//                   height: 45.h,
//                   width: 45.w,
//                   child: _buildLeadingImage(leadingImagePath!),
//                 )
//               else
//                 InkWell(
//                   onTap: onTap ?? () => Get.back(),
//                   child: Image.asset(
//                     ImagePath.newBackArrow,
//                     height: 32.h,
//                     width: 32.w,
//                   ),
//                 ),

//               const Spacer(),

//               // 🔹 Trailing icon (right side)
//               if (trailingIconPath != null)
//                 InkWell(
//                   onTap: onTrailingTap,
//                   borderRadius: BorderRadius.circular(8),
//                   child: SvgPicture.asset(
//                     trailingIconPath!,
//                     height: 44.h,
//                     width: 44.w,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//             ],
//           ),

//           // 🔹 Center title
//           if (title != null)
//             Align(
//               alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   left: centerTitle ? 0 : 60.w,
//                   right: centerTitle ? 0 : 60.w,
//                 ),
//                 child: Text(
//                   title!,
//                   textAlign: centerTitle ? TextAlign.center : TextAlign.left,
//                   style:
//                       textStyle ??
//                       getTextStyle(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600,
//                         color: AppColors.black3,
//                       ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
// import 'package:quick_job/core/utils/constants/app_colors.dart';
// import 'package:quick_job/core/utils/constants/app_sizer.dart';
// import 'package:quick_job/core/utils/constants/image_path.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final double? height;
//   final double? margin;
//   final String? title;
//   final TextStyle? textStyle;
//   final String? iconPath;
//   final VoidCallback? onTap;
//   final EdgeInsetsGeometry? padding;
//   final Color? borderColor;
//   final double? spacing;
//   final Color? backgroundColor;

//   // 🔹 Leading image path (network, file, or asset)
//   final String? leadingImagePath;
//   final String? trailingIconPath;
//   final VoidCallback? onTrailingTap;

//   // 🔹 New property to control title alignment
//   final bool centerTitle;

//   // 🔹 Shimmer / loading flag
//   final bool isLoading;

//   const CustomAppBar({
//     super.key,
//     this.height,
//     this.margin,
//     this.title,
//     this.textStyle,
//     this.iconPath,
//     this.onTap,
//     this.padding,
//     this.borderColor,
//     this.spacing = 0,
//     this.backgroundColor,
//     this.leadingImagePath,
//     this.trailingIconPath,
//     this.onTrailingTap,
//     this.centerTitle = false,
//     this.isLoading = false,
//   });

//   @override
//   Size get preferredSize => Size.fromHeight(height?.h ?? 60.h);

//   // 🔹 Build leading image with shimmer support
//   Widget _buildLeadingImage(String? path) {
//     if (isLoading) {
//       return Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: Container(
//           width: 48,
//           height: 48,
//           decoration: BoxDecoration(
//             color: Colors.grey[300],
//             shape: BoxShape.circle,
//           ),
//         ),
//       );
//     }

//     if (path == null || path.isEmpty) {
//       return CircleAvatar(
//         radius: 24,
//         backgroundImage: AssetImage(ImagePath.user),
//       );
//     } else if (path.startsWith('http')) {
//       return CircleAvatar(
//         radius: 24,
//         backgroundColor: Colors.grey[200],
//         child: ClipOval(
//           child: CachedNetworkImage(
//             imageUrl: path,
//             width: 48,
//             height: 48,
//             fit: BoxFit.cover,
//             placeholder: (context, url) => Shimmer.fromColors(
//               baseColor: Colors.grey[300]!,
//               highlightColor: Colors.grey[100]!,
//               child: Container(
//                 width: 48,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//             errorWidget: (context, url, error) => Icon(Icons.person),
//           ),
//         ),
//       );
//     } else if (File(path).existsSync()) {
//       return CircleAvatar(radius: 24, backgroundImage: FileImage(File(path)));
//     } else {
//       return CircleAvatar(radius: 24, backgroundImage: AssetImage(path));
//     }
//   }

//   // 🔹 Build trailing icon with shimmer
//   Widget _buildTrailingIcon(String? path) {
//     if (isLoading) {
//       return Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: Container(
//           width: 44,
//           height: 44,
//           decoration: BoxDecoration(
//             color: Colors.grey[300],
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//       );
//     }

//     if (path == null) return SizedBox.shrink();

//     return InkWell(
//       onTap: onTrailingTap,
//       borderRadius: BorderRadius.circular(8),
//       child: SvgPicture.asset(
//         path,
//         height: 44.h,
//         width: 44.w,
//         fit: BoxFit.contain,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height?.h ?? 60.h,
//       padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
//       margin: margin != null ? EdgeInsets.only(top: margin!.h) : null,
//       decoration: BoxDecoration(
//         color: backgroundColor ?? AppColors.whitePrimary,
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0x1FA7A6A5),
//             offset: const Offset(-8, 0),
//             blurRadius: 22,
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Row(
//             children: [
//               SizedBox(width: spacing?.w),

//               // 🔹 Leading image or back button
//               if (leadingImagePath != null || isLoading)
//                 SizedBox(
//                   height: 45.h,
//                   width: 45.w,
//                   child: _buildLeadingImage(leadingImagePath),
//                 )
//               else
//                 InkWell(
//                   onTap: onTap ?? () => Get.back(),
//                   child: Image.asset(
//                     ImagePath.newBackArrow,
//                     height: 32.h,
//                     width: 32.w,
//                   ),
//                 ),

//               const Spacer(),

//               // 🔹 Trailing icon
//               _buildTrailingIcon(trailingIconPath),
//             ],
//           ),

//           // 🔹 Center title with shimmer
//           if (title != null || isLoading)
//             Align(
//               alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   left: centerTitle ? 0 : 60.w,
//                   right: centerTitle ? 0 : 60.w,
//                 ),
//                 child: isLoading
//                     ? Shimmer.fromColors(
//                         baseColor: Colors.grey[300]!,
//                         highlightColor: Colors.grey[100]!,
//                         child: Container(
//                           height: 20.h,
//                           width: 120.w,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       )
//                     : Text(
//                         title!,
//                         textAlign: centerTitle
//                             ? TextAlign.center
//                             : TextAlign.left,
//                         style:
//                             textStyle ??
//                             getTextStyle(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.black3,
//                             ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
// import 'package:quick_job/core/utils/constants/app_colors.dart';
// import 'package:quick_job/core/utils/constants/app_sizer.dart';
// import 'package:quick_job/core/utils/constants/image_path.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final double? height;
//   final double? margin;
//   final String? title;
//   final TextStyle? textStyle;
//   final String? iconPath;
//   final VoidCallback? onTap;
//   final EdgeInsetsGeometry? padding;
//   final Color? borderColor;
//   final double? spacing;
//   final Color? backgroundColor;

//   final String? leadingImagePath;
//   final String? trailingIconPath;
//   final VoidCallback? onTrailingTap;

//   /// false = start, true = center
//   final bool centerTitle;
//   final bool isLoading;

//   const CustomAppBar({
//     super.key,
//     this.height,
//     this.margin,
//     this.title,
//     this.textStyle,
//     this.iconPath,
//     this.onTap,
//     this.padding,
//     this.borderColor,
//     this.spacing = 0,
//     this.backgroundColor,
//     this.leadingImagePath,
//     this.trailingIconPath,
//     this.onTrailingTap,
//     this.centerTitle = false,
//     this.isLoading = false,
//   });

//   @override
//   Size get preferredSize => Size.fromHeight(height?.h ?? 60.h);

//   Widget _buildLeadingImage(String? path) {
//     if (isLoading) {
//       return Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: Container(
//           width: 48,
//           height: 48,
//           decoration: const BoxDecoration(
//             color: Colors.grey,
//             shape: BoxShape.circle,
//           ),
//         ),
//       );
//     }

//     if (path == null || path.isEmpty) {
//       return CircleAvatar(
//         radius: 24,
//         backgroundImage: AssetImage(ImagePath.user),
//       );
//     } else if (path.startsWith('http')) {
//       return CircleAvatar(
//         radius: 24,
//         backgroundColor: Colors.grey[200],
//         child: ClipOval(
//           child: CachedNetworkImage(
//             imageUrl: path,
//             width: 48,
//             height: 48,
//             fit: BoxFit.cover,
//             placeholder: (_, __) => Shimmer.fromColors(
//               baseColor: Colors.grey[300]!,
//               highlightColor: Colors.grey[100]!,
//               child: Container(
//                 width: 48,
//                 height: 48,
//                 decoration: const BoxDecoration(
//                   color: Colors.grey,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//             errorWidget: (_, __, ___) => const Icon(Icons.person),
//           ),
//         ),
//       );
//     } else if (File(path).existsSync()) {
//       return CircleAvatar(radius: 24, backgroundImage: FileImage(File(path)));
//     } else {
//       return CircleAvatar(radius: 24, backgroundImage: AssetImage(path));
//     }
//   }

//   Widget _buildTrailingIcon(String? path) {
//     if (isLoading) {
//       return Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: Container(
//           width: 44,
//           height: 44,
//           decoration: BoxDecoration(
//             color: Colors.grey[300],
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//       );
//     }

//     if (path == null) return const SizedBox.shrink();

//     return InkWell(
//       onTap: onTrailingTap,
//       borderRadius: BorderRadius.circular(8),
//       child: SvgPicture.asset(
//         path,
//         height: 44.h,
//         width: 44.w,
//         fit: BoxFit.contain,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height?.h ?? 60.h,
//       padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
//       margin: margin != null ? EdgeInsets.only(top: margin!.h) : null,
//       decoration: BoxDecoration(
//         color: backgroundColor ?? AppColors.whitePrimary,
//         boxShadow: const [
//           BoxShadow(
//             color: Color(0x1FA7A6A5),
//             offset: Offset(-8, 0),
//             blurRadius: 22,
//           ),
//         ],
//       ),
//       child: Stack(
//         alignment: Alignment.centerLeft, // ✅ FIXED
//         children: [
//           Row(
//             children: [
//               SizedBox(width: spacing?.w),
//               if (leadingImagePath != null || isLoading)
//                 SizedBox(
//                   height: 45.h,
//                   width: 45.w,
//                   child: _buildLeadingImage(leadingImagePath),
//                 )
//               else
//                 InkWell(
//                   onTap: onTap ?? () => Get.back(),
//                   child: Image.asset(
//                     ImagePath.newBackArrow,
//                     height: 32.h,
//                     width: 32.w,
//                   ),
//                 ),
//               const Spacer(),
//               _buildTrailingIcon(trailingIconPath),
//             ],
//           ),

//           if (title != null || isLoading)
//             Align(
//               alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: centerTitle ? 0 : 60.w,
//                 ),
//                 child: isLoading
//                     ? Shimmer.fromColors(
//                         baseColor: Colors.grey[300]!,
//                         highlightColor: Colors.grey[100]!,
//                         child: Container(
//                           height: 20.h,
//                           width: 120.w,
//                           decoration: BoxDecoration(
//                             color: Colors.grey[300],
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                       )
//                     : Text(
//                         title!,
//                         textAlign: centerTitle
//                             ? TextAlign.center
//                             : TextAlign.left,
//                         style:
//                             textStyle ??
//                             getTextStyle(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.black3,
//                             ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import 'package:quick_job/core/utils/constants/app_colors.dart';
import 'package:quick_job/core/utils/constants/app_sizer.dart';
import 'package:quick_job/core/utils/constants/image_path.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final double? margin;
  final double? topPadding; // ✅ New top padding
  final String? title;
  final TextStyle? textStyle;
  final String? iconPath;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  final double? spacing;
  final Color? backgroundColor;

  final String? leadingImagePath;
  final String? trailingIconPath;
  final VoidCallback? onTrailingTap;

  /// false = start, true = center
  final bool centerTitle;
  final bool isLoading;

  const CustomAppBar({
    super.key,
    this.height,
    this.margin,
    this.topPadding,
    this.title,
    this.textStyle,
    this.iconPath,
    this.onTap,
    this.padding,
    this.borderColor,
    this.spacing = 0,
    this.backgroundColor,
    this.leadingImagePath,
    this.trailingIconPath,
    this.onTrailingTap,
    this.centerTitle = false,
    this.isLoading = false,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(height?.h ?? 60.h + (topPadding ?? 0));

  Widget _buildLeadingImage(String? path) {
    if (isLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      );
    }

    if (path == null || path.isEmpty) {
      return CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"),
      );
    } else if (path.startsWith('http')) {
      return CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey[200],
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: path,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            placeholder: (_, __) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            errorWidget: (_, __, ___) => const Icon(Icons.person),
          ),
        ),
      );
    } else if (File(path).existsSync()) {
      return CircleAvatar(radius: 24, backgroundImage: FileImage(File(path)));
    } else {
      return CircleAvatar(radius: 24, backgroundImage: AssetImage(path));
    }
  }

  Widget _buildTrailingIcon(String? path) {
    if (isLoading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }

    if (path == null) return const SizedBox.shrink();

    return InkWell(
      onTap: onTrailingTap,
      borderRadius: BorderRadius.circular(8),
      child: SvgPicture.asset(
        path,
        height: 44.h,
        width: 44.w,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double defaultTopPadding =
        topPadding ?? MediaQuery.of(context).padding.top;

    return Container(
      padding:
          padding ??
          EdgeInsets.only(left: 16.w, right: 16.w, top: defaultTopPadding),
      margin: margin != null ? EdgeInsets.only(top: margin!.h) : null,
      height: height?.h ?? 60.h + defaultTopPadding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.whitePrimary,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1FA7A6A5),
            offset: Offset(-8, 0),
            blurRadius: 22,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Row(
            children: [
              SizedBox(width: spacing?.w),
              if (leadingImagePath != null || isLoading)
                SizedBox(
                  height: 45.h,
                  width: 45.w,
                  child: _buildLeadingImage(leadingImagePath),
                )
              else
                InkWell(
                  onTap: onTap ?? () => Get.back(),
                  child: Image.asset(
                    ImagePath.newBackArrow,
                    height: 32.h,
                    width: 32.w,
                  ),
                ),
              const Spacer(),
              _buildTrailingIcon(trailingIconPath),
            ],
          ),
          if (title != null || isLoading)
            Align(
              alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: centerTitle ? 0 : 60.w,
                ),
                child: isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    : Text(
                        title!,
                        textAlign: centerTitle
                            ? TextAlign.center
                            : TextAlign.left,
                        style:
                            textStyle ??
                            getTextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black3,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
            ),
        ],
      ),
    );
  }
}
