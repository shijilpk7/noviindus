import 'package:flutter/material.dart';
import 'package:noviindus/utils/app_colors.dart';

class NoDataFound extends StatelessWidget {
  final void Function()? onRefresh;
  final String? text;
  const NoDataFound({super.key, this.onRefresh, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Text(
            text ?? "No Data Found",
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: AppColors.black),
          ),
          if (onRefresh != null)
            IconButton(
              onPressed: onRefresh,
              icon: const Icon(Icons.refresh_rounded, size: 30),
            ),
        ],
      ),
    );
  }
}
