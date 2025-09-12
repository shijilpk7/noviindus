import 'package:flutter/material.dart';
import 'package:noviindus/utils/app_colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Badge(
            backgroundColor: AppColors.error,
            child: Icon(
              Icons.notifications_none,
              size: 22,
              color: AppColors.notificationColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
