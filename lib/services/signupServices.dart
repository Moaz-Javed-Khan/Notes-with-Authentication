import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/views/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

signUpUser(
  String userName,
  String userEmail,
  String userPhone,
  String userPassword,
) async {
  User? userid = FirebaseAuth.instance.currentUser;

  try {
    await FirebaseFirestore.instance.collection("users").doc(userid!.uid).set({
      'userName': userName,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'createdAt': DateTime.now(),
      'userId': userid.uid,
    }).then((value) => {
          FirebaseAuth.instance.signOut(),
          Get.to(() => LoginScreen()),
        });
  } on FirebaseAuthException catch (e) {
    print("Error $e");
  }
}
