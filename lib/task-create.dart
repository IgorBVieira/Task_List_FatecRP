// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TaskCreatePage extends StatelessWidget {
  TaskCreatePage({super.key});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtCategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cria Tarefa"),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: txtName,
                decoration: const InputDecoration(
                  hintText: "Nome Tarefa",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: txtCategory,
                decoration: const InputDecoration(
                  hintText: "Categoria",
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                  width: double.infinity,
                  child: Container(
                    margin: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        firestore.collection('tasks').add({
                          'name': txtName.text,
                          'category': txtCategory.text,
                          'finished': false,
                          'uid': auth.currentUser!.uid 
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Confirmar'),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
