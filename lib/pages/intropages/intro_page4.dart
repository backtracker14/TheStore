import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:htu_capstone_project0/assets/components/my_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import '../log_in_page.dart';
import '../main_page.dart';

class IntroPage4 extends StatelessWidget {
  const IntroPage4({super.key});

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
                AppLocalizations.of(context)!.getStarted,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 70),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: width / 1.1,
                height: height / 6,
                child: MyButton(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainPage(),
                          maintainState: true),
                      (Route<dynamic> route) => false),
                  myButtonText: AppLocalizations.of(context)!.logIn,
                  fontSize: 70,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
