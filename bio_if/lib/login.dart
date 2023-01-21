import 'package:bio_if/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'cadastro.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String? _status = "";
  String? _statusUsuario = "";

  Future _Login() async {
    var auth = FirebaseAuth.instance;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    try {
      var usuario =
          await auth.signInWithEmailAndPassword(email: email, password: senha);
      var usuarioAtual = await auth.currentUser;
      setState(() {
        _status = "Login realizado com sucesso";
        _statusUsuario = "${usuarioAtual?.email}";
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ));
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "invalid-email") {
        setState(() {
          _status = "Email invalido!!";
        });
      } else if (e.code == "wrong-password") {
        setState(() {
          _status = "Senha invalida!!";
        });
      }
    }
  }

  void _telaCadastro() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Cadastro(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: const Color.fromARGB(255, 04, 82, 37),
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
                ElevatedButton(
                    onPressed: _Login,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    child: Text("Login")),
                Text(_status!),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextButton(
                      onPressed: _telaCadastro,
                      child: const Text("Não tem cadastro? Clique aqui")),
                )
              ],
            ),
          ),
        ));
  }
}
