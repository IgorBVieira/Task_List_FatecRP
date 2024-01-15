// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TaskListPage extends StatelessWidget {
  TaskListPage({super.key});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void update(String id, bool finished) {
    if (finished) {
      firestore.collection('tasks').doc(id).update({'finished': finished});
    }
  }

  void delete(String id) {
    firestore.collection('tasks').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
        actions: [
          IconButton(
            onPressed: () {
              //LogOut
              auth.signOut();
              Navigator.of(context).pop;
            },
            icon: Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore
              .collection('tasks')
              .where('uid', isEqualTo: auth.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            if (snapshot.hasError) return Text(snapshot.error.toString());

            var storedTasks = snapshot.data!.docs;
            return ListView(
              scrollDirection: Axis.vertical,
              children: storedTasks
                  .map((task) => Dismissible(
                        key: Key(task.id),
                        onDismissed: (_) => delete(task.id),
                        background: Container(
                          color: Colors.redAccent,
                        ),
                        child: Card(
                          child: CheckboxListTile(
                            title: Text(task['name']),
                            subtitle: Text(task['category']),
                            value: task['finished'],
                            onChanged: (value) => update(task.id, value!),
                            //TODO: Resolver o clique do botão da tarefa(Preenchido e não preenchido)

                            // subtitle: Text(t['priority']),
                          ),
                        ),
                      ))
                  .toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/task-create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
