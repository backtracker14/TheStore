import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                AppLocalizations.of(context)!.and,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 78),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset('lib/assets/images/truck.gif',
                  height: height / 2.5, color: Colors.white),
              Text(
                AppLocalizations.of(context)!.delivery,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 78),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
