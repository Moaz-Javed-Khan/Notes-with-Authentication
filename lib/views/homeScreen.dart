import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/views/createNoteScreen.dart';
import 'package:finalproject/views/editNoteScreen.dart';
import 'package:finalproject/views/sideDrawerHeader.dart';
import 'package:finalproject/views/sideDrawerList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Notes'),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              SideDrawerHeader(),
              SideDrawerList(),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("notes")
                .where("userId", isEqualTo: userId?.uid)
                .snapshots(),
            builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went Wrong"),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No data found"),
                );
              } else if (snapshot != null && snapshot.data != null) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var note = snapshot.data!.docs[index]['note'];
                    var docId = snapshot.data!.docs[index].id;
                    return Card(
                      child: ListTile(
                        title: Text(note),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const EditNoteScreen(),
                                    arguments: {
                                      'note': note,
                                      'docId': docId,
                                    });
                              },
                              child: const Icon(Icons.edit),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('notes')
                                    .doc(docId)
                                    .delete();
                              },
                              child: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              return Container();
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CreateNoteScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
