import 'package:crypto_tracker/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 845),
      builder: (context, child) => const MaterialApp(
        title: 'Crypto Tracker',
        home: HomeView(),
      ),
    );
  }
}
