// import 'package:flutter/material.dart';

// import '../../utils/constants/app_sizes.dart';
// import 'custom_text.dart';
// import '../../utils/constants/app_colors.dart';

// class CustomDropdownField extends StatelessWidget {
//   final String? label;
//   final String hintText;
//   final bool withAsterisk;
//   final List<String> items;
//   final String selectedValue;
//   final Color? borderColor;
//   final ValueChanged<String> onChanged;

//   const CustomDropdownField({
//     super.key,
//     this.label,
//     required this.hintText,
//     this.withAsterisk = false,
//     required this.items,
//     required this.selectedValue,
//     this.borderColor = const Color(0xffB8B8B8),
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Label with red asterisk
//         // RichText(
//         //   text: TextSpan(
//         //     children: [
//         //       TextSpan(
//         //         text: label,
//         //         style: GoogleFonts.poppins(
//         //           fontSize: getWidth(16),
//         //           color: AppColors.formLabel,
//         //         ),
//         //       ),
//         //       if (withAsterisk)
//         //         TextSpan(
//         //           text: '*',
//         //           style: GoogleFonts.poppins(
//         //             fontSize: getWidth(14),
//         //             color: AppColors.asteriskColor,
//         //           ),
//         //         ),
//         //     ],
//         //   ),
//         // ),
//         //SizedBox(height: getHeight(6)),

//         /// Dropdown field with PopupMenu
//         Container(
//           // height: getHeight(48),
//           padding: EdgeInsets.symmetric(
//             horizontal: getWidth(18),
//             vertical: getHeight(15),
//           ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(4),
//             border: Border.all(
//               color: AppColors.textFormFieldBorder,
//               width: getWidth(1),
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Selected Value or Hint Text
//               CustomText(
//                 textOverflow: TextOverflow.ellipsis,
//                 fontWeight: FontWeight.w500,
//                 fontSize: getWidth(14),
//                 text: selectedValue.isEmpty ? hintText : selectedValue,
//                 color: selectedValue.isEmpty
//                     ? AppColors.textPrimary
//                     : AppColors.textPrimary,
//               ),

//               // Dropdown Icon with PopupMenuButton
//               PopupMenuButton<String>(
//                 color: Colors.white,
//                 onSelected: onChanged,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 constraints: BoxConstraints(
//                   maxWidth: getWidth(500),
//                   maxHeight: getHeight(400),
//                 ),
//                 offset: Offset(getWidth(0), getHeight(20)),
//                 child: Icon(Icons.keyboard_arrow_down, size: getHeight(24)),
//                 // Popup menu items
//                 itemBuilder: (context) {
//                   return items.map((item) {
//                     return PopupMenuItem<String>(
//                       value: item,
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: CustomText(
//                           text: item,
//                           fontWeight: FontWeight.w500,
//                           fontSize: getWidth(16),
//                         ),
//                       ),
//                     );
//                   }).toList();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
// import '../../utils/constants/app_sizes.dart';
// import 'custom_text.dart';
// import '../../utils/constants/app_colors.dart';

// class CustomDropdownField extends StatelessWidget {
//   final String? label;
//   final String hintText;
//   final bool withAsterisk;
//   final List<String> items;
//   final String selectedValue;
//   final Color? borderColor;
//   final ValueChanged<String> onChanged;

//   CustomDropdownField({
//     super.key,
//     this.label,
//     required this.hintText,
//     this.withAsterisk = false,
//     required this.items,
//     required this.selectedValue,
//     this.borderColor = const Color(0xffB8B8B8),
//     required this.onChanged,
//   });

//   final GlobalKey _buttonKey = GlobalKey();

//   void _showPopup(BuildContext context) async {
//     final RenderBox renderBox =
//         _buttonKey.currentContext!.findRenderObject() as RenderBox;

//     final Offset buttonPosition = renderBox.localToGlobal(Offset.zero);

//     final RelativeRect position = RelativeRect.fromLTRB(
//       buttonPosition.dx + renderBox.size.width, // RIGHT side (START)
//       buttonPosition.dy + renderBox.size.height, // BOTTOM
//       buttonPosition.dx,
//       0,
//     );

//     final selected = await showMenu<String>(
//       context: context,
//       position: position,
//       constraints: BoxConstraints(
//         maxWidth: renderBox.size.width, // Never exceed button
//         maxHeight: getHeight(400),
//       ),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       color: Colors.white,
//       items: items
//           .map(
//             (item) => PopupMenuItem<String>(
//               value: item,
//               child: CustomText(
//                 text: item,
//                 fontWeight: FontWeight.w500,
//                 fontSize: getWidth(16),
//               ),
//             ),
//           )
//           .toList(),
//     );

//     if (selected != null) {
//       onChanged(selected);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// Label
//         RichText(
//           text: TextSpan(
//             children: [
//               TextSpan(
//                 text: label ?? "",
//                 style: getTextStyle(
//                   fontSize: getWidth(16),
//                   color: AppColors.black4,
//                 ),
//               ),
//               if (withAsterisk)
//                 TextSpan(
//                   text: '*',
//                   style: getTextStyle(
//                     fontSize: getWidth(14),
//                     color: AppColors.inActiveColor,
//                   ),
//                 ),
//             ],
//           ),
//         ),

//         SizedBox(height: getHeight(12)),

//         /// Button
//         GestureDetector(
//           key: _buttonKey,
//           onTap: () => _showPopup(context),
//           child: Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: getWidth(18),
//               vertical: getHeight(15),
//             ),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(4),
//               border: Border.all(
//                 color: AppColors.textFormFieldBorder,
//                 width: getWidth(1),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: CustomText(
//                     textOverflow: TextOverflow.ellipsis,
//                     fontWeight: FontWeight.w500,
//                     fontSize: getWidth(14),
//                     text: selectedValue.isEmpty ? hintText : selectedValue,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 Icon(Icons.keyboard_arrow_down, size: getHeight(24)),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:quick_job/core/custom/my_widgets/global_text_style.dart';
import '../../utils/constants/app_sizes.dart';
import 'custom_text.dart';
import '../../utils/constants/app_colors.dart';

class CustomDropdownField extends StatelessWidget {
  final String? label;
  final String hintText;
  final bool withAsterisk;
  final List<String> items;
  final String selectedValue;
  final Color? borderColor;
  final ValueChanged<String> onChanged;

  CustomDropdownField({
    super.key,
    this.label,
    required this.hintText,
    this.withAsterisk = false,
    required this.items,
    required this.selectedValue,
    this.borderColor = const Color(0xffB8B8B8),
    required this.onChanged,
  });

  final GlobalKey _buttonKey = GlobalKey();

  void _showPopup(BuildContext context) async {
    final RenderBox renderBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;

    final Offset buttonPosition = renderBox.localToGlobal(Offset.zero);

    final RelativeRect position = RelativeRect.fromLTRB(
      buttonPosition.dx + renderBox.size.width, // RIGHT side (START)
      buttonPosition.dy + renderBox.size.height, // BOTTOM
      buttonPosition.dx,
      0,
    );

    final selected = await showMenu<String>(
      context: context,
      position: position,
      constraints: BoxConstraints(
        maxWidth: renderBox.size.width,
        maxHeight: getHeight(400),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.white,
      items: items
          .map(
            (item) => PopupMenuItem<String>(
              value: item,
              child: CustomText(
                text: item,
                fontWeight: FontWeight.w500,
                fontSize: getWidth(16),
              ),
            ),
          )
          .toList(),
    );

    if (selected != null) {
      onChanged(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label ?? "",
                style: getTextStyle(
                  fontSize: getWidth(16),
                  color: AppColors.black4,
                ),
              ),
              if (withAsterisk)
                TextSpan(
                  text: '*',
                  style: getTextStyle(
                    fontSize: getWidth(14),
                    color: AppColors.inActiveColor,
                  ),
                ),
            ],
          ),
        ),

        SizedBox(height: getHeight(12)),

        // Button
        GestureDetector(
          key: _buttonKey,
          onTap: () => _showPopup(context),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: getWidth(18),
              vertical: getHeight(15),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: borderColor ?? AppColors.textFormFieldBorder,
                width: getWidth(1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomText(
                    textOverflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w500,
                    fontSize: getWidth(14),
                    text: selectedValue.isEmpty ? hintText : selectedValue,
                    color: AppColors.textPrimary,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, size: getHeight(24)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
