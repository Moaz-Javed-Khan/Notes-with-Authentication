import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/views/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({Key? key}) : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController noteController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Edit Note",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextFormField(
                controller: noteController
                  ..text = Get.arguments['note'].toString(),
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Edit Note",
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection("notes")
                      .doc(
                        Get.arguments['docId'].toString(),
                      )
                      .update(
                    {
                      'note': noteController.text.trim(),
                    },
                  ).then((value) => {Get.offAll(() => const HomeScreen())});
                },
                child: const Text("Update Note"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
