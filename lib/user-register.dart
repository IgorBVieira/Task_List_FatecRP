// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserRegisterPage extends StatelessWidget {
  UserRegisterPage({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
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
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await auth.createUserWithEmailAndPassword(
                        email: txtEmail.text,
                        password: txtSenha.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Registrado com sucesso"),
                        backgroundColor: Colors.green,
                      ));
                    } catch (e) {
                      String message = e.toString();
                      print(e);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Erro ao registrar $message"),
                        backgroundColor: Colors.red,
                      ));
                    }
                    Navigator.of(context).pushReplacementNamed('/user-login');
                  },
                  child: const Text('Registrar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
