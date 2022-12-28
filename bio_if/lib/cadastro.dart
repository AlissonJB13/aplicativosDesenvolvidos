import 'package:flutter/material.dart';

//cadastro dos usuarios
class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text("Login / Cadastro de Usuário"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Cadastro"),
          ],
        ),
      ),
    );
  }
}
