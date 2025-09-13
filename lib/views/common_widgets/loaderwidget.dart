import 'package:flutter/cupertino.dart';
import 'package:noviindus/utils/app_colors.dart';

class LoaderWidget extends StatelessWidget {
  final Color? color;
  const LoaderWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(color: color ?? AppColors.white),
    );
  }
}
