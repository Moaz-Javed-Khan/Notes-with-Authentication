// ignore_for_file: deprecated_member_use

import 'package:finalproject/views/loginScreen.dart';
import 'package:finalproject/views/onboardingContent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController _controller;
  User? user;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Image.asset(
                        contents[i].image,
                        height: 300.0,
                      ),
                      Text(
                        contents[i].title,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        contents[i].description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => buildDot(index, currentIndex, context),
                )),
          ),
          Container(
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.all(40),
            child: SizedBox(
              // height: 5,
              child: TextButton(
                style: TextButton.styleFrom(
                  // fixedSize: const Size(300, 100),
                  // fixedSize: const Size.fromHeight(10),
                  backgroundColor: Colors.deepPurple,
                ),
                child: Text(
                  currentIndex == contents.length - 1 ? "Continue" : "Next",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (currentIndex == contents.length - 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => user != null
                              ? const HomeScreen()
                              : const LoginScreen()),
                    );
                  }
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.linear,
                  );
                },
              ),
            ),
            // FlatButton(
            //   // ignore: sort_child_properties_last
            //   child: Text(
            //       currentIndex == contents.length - 1 ? "Continue" : "Next"),
            //   onPressed: () {},
            //   color: ,
            //   textColor: Colors.white,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }
}

Container buildDot(int index, int currentIndex, BuildContext context) {
  return Container(
    height: 10,
    width: currentIndex == index ? 25 : 10,
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.deepPurple,
    ),
  );
}
