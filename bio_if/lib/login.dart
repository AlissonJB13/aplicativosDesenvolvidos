import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String? _status = "";

  Future _Login() async {
    var auth = FirebaseAuth.instance;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    try {
      var usuario =
          await auth.signInWithEmailAndPassword(email: email, password: senha);
      setState(() {
        _status = "Login realizado com sucesso";
      });
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                  controller: _controllerEmail,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Senha",
                  ),
                  controller: _controllerSenha,
                ),
                ElevatedButton(onPressed: _Login, child: Text("Login")),
                Text(_status!),
              ],
            ),
          ),
        ));
  }
}
