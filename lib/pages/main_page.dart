import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:htu_capstone_project0/pages/log_in_page.dart';

import 'auth/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return const LogInPage();
          }
        }),
      ),
    );
  }
}
