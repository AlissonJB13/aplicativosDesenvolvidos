import 'package:bio_if/login.dart';
import 'package:bio_if/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//cadastro dos usuarios
class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  var db = FirebaseFirestore.instance;
  String? _status = "Nenhum erro encontrado!!";

  Future _cadastrarUsuario() async {
    var auth = FirebaseAuth.instance;
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    try {
      var usuario = await auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      print(
          "usuario criado com sucesso: ID: ${usuario.user!.uid} - Email ${usuario.user!.email}");
      setState(() {
        _status = "Usuário criado com sucesso!!";
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ));
      Usuario user = Usuario(
          id: usuario.user!.uid, nome: nome, email: email, senha: senha);
      db.collection("Usuario").doc(usuario.user!.uid).set(user.toMap());
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == "email-already-in-use") {
        setState(() {
          _status = "Email ja em uso!!";
        });
      } else if (e.code == "weak-password") {
        setState(() {
          _status = "Senha fraca!! Sua senha precisa ter 6 caracteres";
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 04, 82, 37),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Nome",
            ),
            controller: _controllerNome,
          ),
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
            onPressed: _cadastrarUsuario,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 04, 82, 37)),
            child: const Text("Criar cadastro"),
          ),
          Text(_status!),
        ]),
      )),
    );
  }
}
