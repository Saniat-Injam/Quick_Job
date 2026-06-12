import 'package:flutter/material.dart';

class RecentlyAppliedSkeleton extends StatelessWidget {
  const RecentlyAppliedSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
