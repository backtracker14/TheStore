// ignore_for_file: unused_import, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:htu_capstone_project0/assets/components/models.dart';
import 'package:htu_capstone_project0/assets/controllers/some_controllers.dart';
import 'package:htu_capstone_project0/pages/auth/account_settings_page.dart';
import 'package:htu_capstone_project0/pages/auth/home_page.dart';
import 'package:htu_capstone_project0/pages/auth/cart.dart';
import 'package:htu_capstone_project0/pages/auth/category.dart';
import 'package:htu_capstone_project0/pages/auth/order_history.dart';
import 'package:htu_capstone_project0/pages/auth/product.dart';
import 'package:htu_capstone_project0/pages/intropages/intro_page0.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController _languageController =
        Get.put(LanguageController());

    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        iconButtonTheme: IconButtonThemeData(
          style:
              ButtonStyle(iconColor: MaterialStateProperty.all(Colors.white)),
        ),
        appBarTheme: const AppBarTheme(
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.red.shade900,
            onPrimary: Colors.grey.shade300,
            secondary: Colors.white,
            onSecondary: Colors.red.shade900,
            error: Colors.red.shade700,
            onError: Colors.white,
            background: Colors.grey.shade400,
            onBackground: Colors.black54,
            surface: Colors.cyan,
            onSurface: Colors.grey.shade300),
      ),
      title: "T H E  S T O R E",
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      debugShowCheckedModeBanner: false,
      home: IntroPageMain(),
    );
  }
}

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryList(), fenix: true);
    Get.lazyPut(() => ProductPage(), fenix: true);
    Get.lazyPut(() => CartPage(), fenix: true);
    Get.lazyPut(() => OrderHistoryPage(), fenix: true);
    Get.lazyPut(() => const AccountSettingsPage(), fenix: true);
  }
}
