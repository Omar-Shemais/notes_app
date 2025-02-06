import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/core/caching_utils/caching_utils.dart';

import 'core/utils.dart';
import 'features/home/view.dart';
import 'features/login/view.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  await CachingUtils.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        ScreenUtil.init(
          context,
          designSize: const Size(414, 896),
        );
        return child!;
      },
      theme: Utils.appTheme,
      title: "Notes",
      home: CachingUtils.isLogged ? HomeView() : LoginView(),
    );
  }
}
