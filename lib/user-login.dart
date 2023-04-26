// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserLoginPage extends StatelessWidget {
  UserLoginPage({super.key});
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController txtEmail =
      TextEditingController(); //Controla o que é enviado pro banco
  final TextEditingController txtSenha = TextEditingController();

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
              controller: txtEmail,
              decoration: const InputDecoration(
                labelText: 'E-mail',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              obscureText: true,
              controller: txtSenha,
              decoration: const InputDecoration(
                labelText: 'Senha',
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async{
                  try { 
                   await auth.signInWithEmailAndPassword(
                      email: txtEmail.text,
                      password: txtSenha.text,
                    );
                    Navigator.of(context).pushNamed('/task-list');
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Logar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
