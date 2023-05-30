import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.red[900],
          alignment: Alignment.center,
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Title
              Text(
                AppLocalizations.of(context)!.title,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 50),
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Text(
              //   'by M.S. Obeidat',
              //   style: GoogleFonts.roboto(
              //     textStyle: Theme.of(context).textTheme.titleSmall,
              //   ),
              // ),

              //App Logo
              Image.asset(
                "lib/assets/images/logo.gif",
                height: height / 2.5,
                color: Colors.white,
                // colorBlendMode: BlendMode.darken,
                // repeat: ImageRepeat.noRepeat,
              ),

              //Description
              Text(
                AppLocalizations.of(context)!.description,
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                  fontSize: 12,
                ),
              ),

              //slide instruction
              Text(
                AppLocalizations.of(context)!.slidePrompt,
                style: const TextStyle(color: Colors.white),
              ),

              //slide arrow
              // Image.asset(
              //   'lib/assets/images/right-arrow.gif',
              //   height: height / 10,
              //   width: width,
              //   fit: BoxFit.fitWidth,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
