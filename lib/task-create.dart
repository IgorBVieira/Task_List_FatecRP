// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TaskCreatePage extends StatelessWidget {
  TaskCreatePage({super.key});
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance; // Linha de conexão com banco
  final TextEditingController txtName = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO APP"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: const InputDecoration(
                hintText: "PlaceHolder",
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  firestore.collection('tasks').add({
                    'name': txtName.text,
                    'finished': false,
                    'uid': auth.currentUser!.uid //cadastrar uid
                  }); //Insert no firebase
                  Navigator.of(context).pop();
                },
                child: const Text('Confirmar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
