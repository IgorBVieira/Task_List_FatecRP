// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TaskCreatePage extends StatelessWidget {
  const TaskCreatePage({super.key});

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
            const TextField(),
            Container(
              color: Colors.amber,
              child: const Material(
                child: ListTile(
                  title: Text('data'),
                  tileColor: Colors.amberAccent,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Voltar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
