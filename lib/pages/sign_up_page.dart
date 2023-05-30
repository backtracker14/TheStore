import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:htu_capstone_project0/pages/auth/home_page.dart';
import 'package:htu_capstone_project0/pages/log_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //EMAIL & PASSWORD CONTROLLERS
  final emailContoller = TextEditingController();
  final passwordController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumController = TextEditingController();
  final dOBController = TextEditingController();

  Future<void> signUp() async {
    try {
      // Create user account
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailContoller.text.trim(),
        password: passwordController.text,
      );

      // Get the UID of the newly created user
      String uid = userCredential.user!.uid;

      // Add user details to the "users" collection
      await addUserDetails(
        uid,
        fNameController.text.trim(),
        lNameController.text.trim(),
        emailContoller.text.trim(),
        addressController.text.trim(),
        int.parse(phoneNumController.text.trim()),
        int.parse(dOBController.text.trim()),
      );

      Get.to(HomePage());
    } catch (e) {
      // Handle sign-up errors
      if (kDebugMode) {
        print('Error during sign up: $e');
      }
    }
  }

  //create user details

  Future addUserDetails(String uid, String firstName, String lastName,
      String email, String address, int phoneNumber, int dOB) async {
    await FirebaseFirestore.instance.collection('users').add({
      'uid': uid,
      'first name': firstName,
      'last name': lastName,
      'phone number': phoneNumber,
      'email': email,
      'address': address,
      'date of birth': dOB,
    });
  }

  //dispose of email & pass after sign in
  @override
  void dispose() {
    emailContoller.dispose();
    passwordController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    addressController.dispose();
    phoneNumController.dispose();
    dOBController.dispose();
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
        appBar: AppBar(
          elevation: 0,
          //title
          title: Text(
            AppLocalizations.of(context)!.createAccount,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.grey[200],
        //main column
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // //logo
              // Text(
              //   AppLocalizations.of(context)!.title,
              //   style: GoogleFonts.roboto(
              //     textStyle: Theme.of(context).textTheme.displayLarge,
              //     fontWeight: FontWeight.bold,
              //     color: Theme.of(context).colorScheme.primary,
              //   ),
              // ),
              // //divider
              // const Divider(color: Colors.blueGrey, thickness: 20),
              // //spacer
              // SizedBox(
              //   height: height / 15,
              // ),

              // //sign up text
              // Text(
              //   AppLocalizations.of(context)!.createAccount,
              //   style: GoogleFonts.roboto(
              //     textStyle: Theme.of(context).textTheme.titleLarge,
              //     fontWeight: FontWeight.bold,
              //     color: Theme.of(context).colorScheme.primary,
              //   ),
              // ),

              //spacer
              SizedBox(
                height: height / 25,
              ),

              //textfield for firstname
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: fNameController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    labelText: AppLocalizations.of(context)!.fName,
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: AppLocalizations.of(context)!.fName,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                  ),
                ),
              ),
              //textfield for lastname
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: lNameController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    labelText: AppLocalizations.of(context)!.lName,
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: AppLocalizations.of(context)!.lName,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                  ),
                ),
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
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    labelText: AppLocalizations.of(context)!.email,
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "youremail@address.com",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                  ),
                ),
              ),

              //textfield for phone number
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneNumController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    labelText: AppLocalizations.of(context)!.phoneNo,
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "079 1234567 ",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                  ),
                ),
              ),

              //textfield for date of birth
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.datetime,
                  controller: dOBController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    labelText: AppLocalizations.of(context)!.dob,
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "01 / 05 / 2000",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                  ),
                ),
              ),

              //textfield for address
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  controller: addressController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    labelText: AppLocalizations.of(context)!.address,
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: AppLocalizations.of(context)!.address,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                  ),
                ),
              ),

              // //spacer
              // SizedBox(
              //   height: height / 50,
              // ),

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
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    labelText: AppLocalizations.of(context)!.password,
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "*******",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                  ),
                ),
              ),

              //TODO: implement if statement for confirming password
              //textfield for confirm password
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
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    labelText: AppLocalizations.of(context)!.confirmPassword,
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: "*******",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                  ),
                ),
              ),
              //spacer
              SizedBox(
                height: height / 50,
              ),

              //Sign Up BUTTON
              SizedBox(
                width: width * 0.75,
                height: height / 16,
                child: ElevatedButton(
                  onPressed: (signUp),
                  child: Text(
                    AppLocalizations.of(context)!.signUp,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              //spacer
              SizedBox(
                height: height / 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
