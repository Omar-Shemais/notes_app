import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_app/core/app_colors/app_colors.dart';
import 'package:note_app/core/dimensions/dimensions.dart';
import 'package:note_app/widgets/app_text.dart';

import 'app_button.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.message,
    required this.confirmTitle,
    required this.onConfirm,
    this.onCancel,
  });

  static void show(
    BuildContext context, {
    required String message,
    String confirmTitle = 'Save',
    required void Function() onConfirm,
    void Function()? onCancel,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.white.withOpacity(0.1),
      builder: (context) => AppDialog(
        message: message,
        confirmTitle: confirmTitle,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }

  final String message;
  final String confirmTitle;
  final void Function() onConfirm;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 8),
            Icon(
              FontAwesomeIcons.circleInfo,
              color: AppColors.darkGray,
              size: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.height),
              child: AppText(
                title: message,
                fontSize: 24,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: "Discard",
                    color: AppColors.red,
                    onTap: () {
                      if (onCancel == null) {
                        Navigator.pop(context);
                        return;
                      }
                      onCancel!();
                    },
                  ),
                ),
                SizedBox(width: 32.width),
                Expanded(
                  child: AppButton(
                    title: confirmTitle,
                    color: AppColors.green,
                    onTap: onConfirm,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
