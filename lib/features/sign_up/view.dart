import 'package:flutter/material.dart';
import 'package:note_app/core/app_colors/app_colors.dart';
import 'package:note_app/core/dimensions/dimensions.dart';
import 'package:note_app/core/route_utils/route_utils.dart';
import 'package:note_app/core/validator_utils/validator_utils.dart';
import 'package:note_app/features/sign_up/controller.dart';
import 'package:note_app/widgets/app_app_bar.dart';
import 'package:note_app/widgets/app_button.dart';
import 'package:note_app/widgets/app_text.dart';
import 'package:note_app/widgets/app_text_field.dart';

import '../../widgets/app_loading_indicator.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  SignUpController controller = SignUpController();
  bool isLoading = false;

  void toggleLoading(bool value) {
    isLoading = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        enableBackButton: true,
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            SizedBox(height: 32.height),
            AppText(
              title: "Notes App",
              textAlign: TextAlign.center,
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
            SizedBox(height: 40.height),
            AppText(
              title: "Sign up",
              textAlign: TextAlign.center,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 48.height),
            AppTextField(
              hint: 'Name',
              onSaved: (v) => controller.name = v,
              validator: ValidatorUtils.name,
            ),
            Divider(height: 20, color: AppColors.gray),
            AppTextField(
              hint: 'Email',
              onSaved: (v) => controller.email = v,
              validator: ValidatorUtils.email,
            ),
            Divider(height: 20, color: AppColors.gray),
            AppTextField(
              hint: 'Password',
              onSaved: (v) => controller.password = v,
              validator: ValidatorUtils.password,
            ),
            SizedBox(height: 64.height),
            AppButton(
              isLoading: isLoading,
              title: 'Sign up',
              onTap: () async {
                toggleLoading(true);
                await controller.signUp(context);
                toggleLoading(false);
              },
            ),
            SizedBox(height: 48.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  title: 'Do you have an account?',
                  color: AppColors.gray,
                ),
                SizedBox(width: 4.width),
                AppText(
                  title: 'Login',
                  textDecoration: TextDecoration.underline,
                  onTap: () => RouteUtils.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
