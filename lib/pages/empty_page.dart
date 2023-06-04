import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyCat extends StatelessWidget {
  const EmptyCat({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.empty,
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset(
            "lib/assets/images/logo.gif",
            height: Get.height / 2,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
