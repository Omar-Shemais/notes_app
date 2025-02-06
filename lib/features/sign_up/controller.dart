import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:note_app/core/caching_utils/caching_utils.dart';
import 'package:note_app/features/home/view.dart';
import 'package:note_app/widgets/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/route_utils/route_utils.dart';

class SignUpController {
  final formKey = GlobalKey<FormState>();
  String? name, email, password;

  Future<void> signUp(BuildContext context) async {
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      final response = await Dio().post(
        'https://ink-notes-app.onrender.com/api/v1/auth/register',
        data: {
          "email": email,
          "password": password,
          "name": name,
        },
      );
      await CachingUtils.cacheUser(response.data);
      RouteUtils.pushAndPopAll(
        context: context,
        view: HomeView(),
      );
    } on DioException catch (e) {
      showSnackBar(
        context,
        title: e.response?.data['message'] ?? '',
        error: true,
      );
    }
  }
}
