// ignore_for_file: unused_import, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:htu_capstone_project0/main.dart';
import 'package:htu_capstone_project0/pages/sign_up_page.dart';

import '../assets/components/my_button.dart';
import '../assets/components/my_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  //EMAIL & PASSWORD CONTROLLERS
  final emailContoller = TextEditingController();
  final passwordController = TextEditingController();

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailContoller.text.trim(),
        password: passwordController.text,
      );
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Log in failed", "try again");
    }
  }

  //dispose of email & pass after sign in
  @override
  void dispose() {
    emailContoller.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //HEIGHT &WIDTH
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        //appbar
        // appBar: AppBar(
        //   elevation: 0,
        //   //title
        //   title: Text(
        //     AppLocalizations.of(context)!.title,
        //     style: const TextStyle(
        //         color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50),
        //   ),
        // ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        //main column
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //spacer
              SizedBox(
                height: height / 5,
              ),
              //logo
              Text(
                AppLocalizations.of(context)!.title,
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.displayMedium,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                  // fontSize: 80,
                ),
              ),
              //divider
              Divider(
                  color: Theme.of(context).colorScheme.secondary,
                  thickness: 20),
              //spacer
              SizedBox(
                height: height / 15,
              ),

              //sign in text
              Text(
                AppLocalizations.of(context)!.welcomeBack,
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),

              //spacer
              SizedBox(
                height: height / 25,
              ),

              //textfield for email
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailContoller,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    labelText: AppLocalizations.of(context)!.email,
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "youremail@address.com",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    )),
                  ),
                ),
              ),

              //spacer
              SizedBox(
                height: height / 50,
              ),

              //textfield for password
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    labelText: AppLocalizations.of(context)!.password,
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "*******",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    )),
                  ),
                ),
              ),

              //spacer
              SizedBox(
                height: height / 50,
              ),

              //Sign In BUTTON
              SizedBox(
                width: width * 0.75,
                height: height / 16,
                child: ElevatedButton(
                  onPressed: signIn,
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.secondary),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.logIn,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 24),
                  ),
                ),
              ),

              //sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.newUser,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signUp,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
