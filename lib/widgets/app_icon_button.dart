import 'package:flutter/material.dart';
import 'package:note_app/core/dimensions/dimensions.dart';

import '../core/app_colors/app_colors.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.padding = EdgeInsets.zero,
  });

  final IconData icon;
  final void Function() onTap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Padding(
        padding: padding,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            width: 50.width,
            height: 50.height,
            child: Icon(
              icon,
              size: 18.height,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.darkGray,
            ),
          ),
        ),
      ),
    );
  }
}
