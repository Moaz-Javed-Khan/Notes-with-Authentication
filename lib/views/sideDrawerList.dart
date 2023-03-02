import 'package:finalproject/views/loginScreen.dart';
import 'package:finalproject/views/signupScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SideDrawerList extends StatefulWidget {
  const SideDrawerList({Key? key}) : super(key: key);

  @override
  State<SideDrawerList> createState() => _SideDrawerListState();
}

class _SideDrawerListState extends State<SideDrawerList> {
  @override
  Widget build(BuildContext context) {
    bool loggedin = true;
    String? text;

    // ignore: dead_code
    if (loggedin) {
      text = "Logout";
      // ignore: dead_code
    } else {
      text = "Login";
    }

    return Column(
      children: [
        ListTile(
          title: Text(text),
          onTap: () {
            // ignore: dead_code
            if (loggedin) {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
              // ignore: dead_code
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignupScreen(),
                ),
              );
            }
          },
          leading: const Icon(Icons.history),
          // trailing: Icon(Icons.exit_to_app_outlined)
        ),
      ],
    );
  }
}
