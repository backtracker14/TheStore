// ignore_for_file: unused_import, library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:htu_capstone_project0/pages/auth/product_page.dart';
import 'package:htu_capstone_project0/assets/components/models.dart'
    as MyModels;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:htu_capstone_project0/assets/controllers/some_controllers.dart';
import 'package:htu_capstone_project0/pages/auth/about_us.dart';
import 'package:htu_capstone_project0/pages/auth/account_settings_page.dart';
import 'package:htu_capstone_project0/pages/auth/cart.dart';
import 'package:htu_capstone_project0/pages/auth/category.dart';
import 'package:htu_capstone_project0/pages/auth/language_settings_page.dart';
import 'package:htu_capstone_project0/pages/auth/order_history.dart';
import 'package:htu_capstone_project0/read_data/get_user_name.dart';

class HomePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  final CartController cartController = Get.put(CartController());

//document IDs
  final List<String> docIDs = [];

  //get docIDs

  Future getDocID() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          // ignore: avoid_function_literals_in_foreach_calls
          (snapshot) => snapshot.docs.forEach(
            (document) {
              if (kDebugMode) {
                print(document.reference);
              }
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  // @override
  // void initState() {
  //   getDocID();
  //   super.initState();
  // }

  final CollectionReference categoriesRef =
      FirebaseFirestore.instance.collection('categories');
  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.red[800],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            const DrawerHeader(
              //User icon (will implement profile photos if needed)

              child: Icon(
                Icons.person_4,
                size: 150,
              ),
            ),
            Center(
              //display logged in user's name
              child: FutureBuilder(
                initialData: const Text('User'),
                future: getDocID(),
                builder: (context, snapshot) {
                  return const Center(
                    child: ListTile(
                      iconColor: Colors.white,
                      textColor: Colors.white,
                      // tileColor: Colors.red[900],
                      leading: Icon(Icons.verified_user),

                      title: Text('USER NAME'),
                      //TODO fix this piece of trash that stopped working for no reason
                      // GetUserName(
                      //   documentID: docIDs[0],
                      // ),
                      style: ListTileStyle.drawer,
                    ),
                  );
                },
              ),
            ),
            const Divider(
              thickness: 4,
            ),
            ListView(
              shrinkWrap: true,
              children: [
                //order history
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListTile(
                            iconColor: Colors.white,
                            textColor: Colors.white,
                            tileColor: Colors.red[900],
                            title: Text(
                              AppLocalizations.of(context)!.purchaseHistory,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            leading: const Icon(
                              Icons.history,
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                            ),
                            onTap: () {
                              Get.to(OrderHistoryPage());
                            },
                          ),
                        ),
                        //account settings
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListTile(
                            iconColor: Colors.white,
                            textColor: Colors.white,
                            tileColor: Colors.red[900],
                            title: Text(
                              AppLocalizations.of(context)!.accountSettings,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            leading: const Icon(
                              Icons.manage_accounts,
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                            ),
                            onTap: () {
                              Get.to(const AccountSettingsPage());
                            },
                          ),
                        ),
                        //language settings
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListTile(
                            iconColor: Colors.white,
                            textColor: Colors.white,
                            tileColor: Colors.red[900],
                            title: Text(
                              AppLocalizations.of(context)!.languageSettings,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            leading: const Icon(
                              Icons.language,
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                            ),
                            onTap: () {
                              Get.to(LanguageSettingsPage());
                            },
                          ),
                        ),

                        //about us
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListTile(
                            iconColor: Colors.white,
                            textColor: Colors.white,
                            tileColor: Colors.red[900],
                            title: Text(
                              AppLocalizations.of(context)!.aboutUs,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            leading: const Icon(
                              Icons.question_mark,
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                            ),
                            onTap: () {
                              Get.to(const AboutUsPage());
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            ListView(
              //signout
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    tileColor: Colors.grey[800],
                    title: Text(
                      AppLocalizations.of(context)!.logOut,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: const Icon(
                      Icons.logout,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.red[900],
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(),
              ),
            ),
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // const SizedBox(height: 20),
              // const Text(
              //   'Categories',
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 10),
              CategoryList(),
            ],
          ),
        ),
      ),
    );
  }
}
