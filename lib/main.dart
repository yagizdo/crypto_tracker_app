import 'package:crypto_tracker/bloc/currency_bloc/currency_bloc.dart';
import 'package:crypto_tracker/services/locator.dart';
import 'package:crypto_tracker/views/onboarding_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';
import 'i18n/codegen_loader.g.dart';
import 'services/navigation_service.dart';

Future<void> initUtils() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  await setUpInjections();
  await dotenv.load(fileName: ".env");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initUtils();
  runApp(EasyLocalization(
      path: 'lib/i18n/langs',
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
      ],
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CurrencyBloc()),
        ],
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 845),
      builder: (context, child) => MaterialApp(
        title: 'Crypto Tracker',
        home: OnboardingView(),
        navigatorKey: getIt<NavigationService>().navigatorKey,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
      ),
    );
  }
}
