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
            onPressed: () { //LogOut
              auth.signOut();
              Navigator.of(context).pushNamed('/user-login');
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore
              .collection('tasks')
              .where('uid',
                  isEqualTo: auth
                      .currentUser!.uid) // filtro de tarefas do usuario logado
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            var tasks = snapshot.data!.docs;

            return ListView(
              children: tasks
                  .map((t) => Dismissible(
                        key: Key(t.id),
                        onDismissed: (_) => delete(t.id),
                        background: Container(
                          color: Colors.redAccent,
                        ),
                        child: CheckboxListTile(
                          //Estamos dentro do map (para acessar os itens precisa do 't.')
                          onChanged: (value) => update(t.id, value!),
                          value: t['finished'],
                          title: Text(t['name']),
                          //TODO: Resolver o clique do botão da tarefa(Preenchido e não preenchido)

                          // subtitle: Text(t['priority']),
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
