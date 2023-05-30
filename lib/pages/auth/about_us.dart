import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(AppLocalizations.of(context)!.aboutUs),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.house,
                size: Get.height / 5,
              ),
              SizedBox(
                height: Get.height / 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  """You are a senior mobile developer at X Company, the company is need to build a new E-commerce application with two languages arabic and english, to display all products of the company and allow the user to create an orders from the application ,the application include many features like allow users to create an accounts , add his address , Edit the profile and location ,about us to display the some information about the company , add products in cart shopping and place the orders .""",
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
