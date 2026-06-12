import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_job/core/utils/constants/icon_path.dart';

class SuggestionTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const SuggestionTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            SvgPicture.asset(IconPath.clock),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF757575),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
