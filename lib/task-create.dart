// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskCreatePage extends StatelessWidget {
  TaskCreatePage({super.key});
  final FirebaseFirestore firestore =
      FirebaseFirestore.instance; // Linha de conexão com banco
  final TextEditingController txtName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Task"),
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
