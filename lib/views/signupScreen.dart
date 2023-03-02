import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/views/loginScreen.dart';
import 'package:finalproject/services/signupServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController userEmailController = TextEditingController();

  TextEditingController userPhoneController = TextEditingController();

  TextEditingController userPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.2,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    controller: userNameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    // onChanged: (val) {
                    //   titleInput = val;
                    // },
                    // controller: _usernameController,
                    // onSubmitted: (_) => _submitData(),
                  ),
                  TextField(
                    controller: userEmailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    // onChanged: (val) {
                    //   titleInput = val;
                    // },
                    // controller: _usernameController,
                    // onSubmitted: (_) => _submitData(),
                  ),
                  TextField(
                    controller: userPhoneController,
                    decoration:
                        const InputDecoration(labelText: 'Contact Number'),
                    // onChanged: (val) {
                    //   titleInput = val;
                    // },
                    // controller: _usernameController,
                    // onSubmitted: (_) => _submitData(),
                  ),
                  TextField(
                    controller: userPasswordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    // onChanged: (val) {
                    //   titleInput = val;
                    // },
                    // controller: _usernameController,
                    // onSubmitted: (_) => _submitData(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                      primary: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      var userName = userNameController.text.trim();
                      var userEmail = userEmailController.text.trim();
                      var userPhone = userPhoneController.text.trim();
                      var userPassword = userPasswordController.text.trim();

                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: userEmail,
                            password: userPassword,
                          )
                          .then((value) => {
                                log("user created"),
                                signUpUser(
                                  userName,
                                  userEmail,
                                  userPhone,
                                  userPassword,
                                ),
                              });
                    },
                    child: const Text(
                      'Signup',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      const Text("Already have an account? "),
                      TextButton(
                        child: const Text(
                          "Login.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => const LoginScreen());
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const LoginScreen()),
                          // );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
