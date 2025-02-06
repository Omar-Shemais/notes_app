import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:note_app/core/caching_utils/caching_utils.dart';
import 'package:note_app/core/route_utils/route_utils.dart';
import 'package:note_app/features/home/view.dart';

import '../../widgets/snack_bar.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();
  String? email, password;

  Future<void> login(BuildContext context) async {
    formKey.currentState!.save();
    if (!formKey.currentState!.validate()) {
      return;
    }
    try {
      final response = await Dio().post(
        'https://ink-notes-app.onrender.com/api/v1/auth/login',
        data: {
          "email": email,
          "password": password,
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
