// language_settings_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:htu_capstone_project0/assets/controllers/some_controllers.dart';

class LanguageSettingsPage extends StatelessWidget {
  final LanguageController _languageController = Get.find();

  LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.languageSettings),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('English'),
            onTap: () {
              _languageController.setLanguage('en');
              Get.back();
            },
          ),
          ListTile(
            title: const Text('Arabic'),
            onTap: () {
              _languageController.setLanguage('ar');
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
