// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserLoginPage extends StatelessWidget {
  UserLoginPage({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;
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
                onPressed: () async {
                  try {
                    await auth.signInWithEmailAndPassword(
                      email: txtEmail.text,
                      password: txtSenha.text,
                    );
                    Navigator.of(context).pushNamed('/task-list');
                  } catch (e) {
                    print(e); //AlertDialog, Snackbar, Text, Toast
                    //TODO: Fazer o alerta de erro
                    AlertDialog(
                      title: Text('teste'),
                      content: Text('teste'),
                    );
                  }
                },
                child: const Text('Logar'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/user-register'),
                child: const Text('Registrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
