import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "Edit $field",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          //cancel button
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context),
          ),

          //save button
          TextButton(
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          ),
        ],
      ),
    );

    //update in firestore
    if (newValue.trim().isNotEmpty) {
      //only update if there is something  in the textfield
      await userCollection
          .where('uid', isEqualTo: user.uid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        // ignore: avoid_function_literals_in_foreach_calls
        querySnapshot.docs.forEach((doc) async {
          await userCollection.doc(doc.id).update({field: newValue});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.accountSettings),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('uid', isEqualTo: user.uid)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final userData = snapshot.data!.docs.first.data();
              // ignore: unnecessary_null_comparison
              if (userData != null) {
                // ignore: unused_local_variable, unnecessary_cast
                final userDataMap = userData as Map<String, dynamic>;
                return ListView(
                  children: [
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //TODO add a little tip at the top for the user

                        //spacer
                        SizedBox(
                          height: Get.height / 10,
                        ),

                        ListTile(
                          iconColor: (Colors.white),
                          textColor: Theme.of(context).colorScheme.secondary,
                          tileColor: Theme.of(context).colorScheme.error,
                          style: ListTileStyle.list,
                          title: Text(
                            "${AppLocalizations.of(context)!.fName}:",
                          ),
                          subtitle: Text(
                            userData["first name"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.settings),
                            onPressed: () => editField('first name'),
                          ),
                        ),
                        const Divider(),
                        //lastname
                        ListTile(
                          iconColor: (Colors.white),
                          textColor: Theme.of(context).colorScheme.secondary,
                          tileColor: Theme.of(context).colorScheme.error,
                          style: ListTileStyle.list,
                          title:
                              Text("${AppLocalizations.of(context)!.lName}:"),
                          subtitle: Text(
                            userData["last name"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.settings),
                            onPressed: () => editField('last name'),
                          ),
                        ),
                        const Divider(),

                        //email
                        ListTile(
                          iconColor: (Colors.white),
                          textColor: Theme.of(context).colorScheme.secondary,
                          tileColor: Theme.of(context).colorScheme.error,
                          style: ListTileStyle.list,
                          title:
                              Text("${AppLocalizations.of(context)!.email}:"),
                          subtitle: Text(
                            userData["email"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.settings),
                            onPressed: () => editField('email'),
                          ),
                        ),
                        const Divider(),
                        //phone
                        ListTile(
                          iconColor: (Colors.white),
                          textColor: Theme.of(context).colorScheme.secondary,
                          tileColor: Theme.of(context).colorScheme.error,
                          style: ListTileStyle.list,
                          title:
                              Text("${AppLocalizations.of(context)!.phoneNo}:"),
                          subtitle: Text(
                            userData["phone number"].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.settings),
                            onPressed: () => editField('phone number'),
                          ),
                        ),

                        const Divider(),
                        //dob
                        ListTile(
                          iconColor: (Colors.white),
                          textColor: Theme.of(context).colorScheme.secondary,
                          tileColor: Theme.of(context).colorScheme.error,
                          style: ListTileStyle.list,
                          title: Text("${AppLocalizations.of(context)!.dob}:"),
                          subtitle: Text(
                            userData["date of birth"].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.settings),
                            onPressed: () => editField('date of birth'),
                          ),
                        ),
                        const Divider(),
                        //address
                        ListTile(
                          iconColor: (Colors.white),
                          textColor: Theme.of(context).colorScheme.secondary,
                          tileColor: Theme.of(context).colorScheme.error,
                          style: ListTileStyle.list,
                          title:
                              Text("${AppLocalizations.of(context)!.address}:"),
                          subtitle: Text(
                            userData["address"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.settings),
                            onPressed: () => editField('address'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error ${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
