import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/views/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({Key? key}) : super(key: key);

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  TextEditingController noteController = TextEditingController();
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Create Notes'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextFormField(
                controller: noteController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Add Note",
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var note = noteController.text.trim();
                  if (note != "") {
                    try {
                      await FirebaseFirestore.instance
                          .collection("notes")
                          .doc()
                          .set({
                        "createdAt": DateTime.now(),
                        "note": note,
                        "userId": userId?.uid,
                      }).then((value) =>
                              {Get.offAll(() => const HomeScreen())});
                    } catch (e) {
                      print("Error $e");
                    }
                  }
                },
                child: const Text("Add Note"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
