import 'package:finalproject/views/forgetPasswordPassowrd.dart';
import 'package:finalproject/views/homeScreen.dart';
import 'package:finalproject/views/signupScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userEmailController = TextEditingController();

  TextEditingController userPasswordController = TextEditingController();

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
                    height: 100,
                  ),
                  TextField(
                    controller: userEmailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    // onChanged: (val) {
                    //   titleInput = val;
                    // },
                    // controller: _usernameController,
                    // onSubmitted: (_) => _submitData(),
                  ),
                  TextField(
                    controller: userPasswordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
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
                    onPressed: () async {
                      var loginEmail = userEmailController.text.trim();
                      var loginPassword = userPasswordController.text.trim();

                      try {
                        final User? firebaseUser = (await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                          email: loginEmail,
                          password: loginPassword,
                        ))
                            .user;
                        if (firebaseUser != null) {
                          Get.to(() => HomeScreen());
                        } else {
                          print('Retry');
                        }
                      } on FirebaseAuthException catch (e) {
                        print("Error $e");
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                      const Text("Don't Have an account "),
                      TextButton(
                        child: const Text(
                          "Signup.",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => SignupScreen());
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const SignupScreen()),
                          // );
                        },
                      ),
                    ],
                  ),
                  TextButton(
                    child: const Text(
                      "Forget Password?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => const ForgetPasswordScreen());
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const SignupScreen()),
                      // );
                    },
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
