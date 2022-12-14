import 'package:crypto_tracker/services/locator.dart';
import 'package:crypto_tracker/views/base_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';
import 'services/navigation_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setUpInjections();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 845),
      builder: (context, child) => MaterialApp(
        title: 'Crypto Tracker',
        home: const BaseView(),
        navigatorKey: getIt<NavigationService>().navigatorKey,
      ),
    );
  }
}
