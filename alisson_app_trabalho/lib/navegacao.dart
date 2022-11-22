import 'package:alisson_app_trabalho/quiz.dart';
import 'package:alisson_app_trabalho/inicio.dart';
import 'package:alisson_app_trabalho/lista.dart';
import 'package:flutter/material.dart';

class Navegacao extends StatefulWidget {
  const Navegacao({super.key});

  @override
  State<Navegacao> createState() => _NavegacaoState();
}

class _NavegacaoState extends State<Navegacao> {
  int _indiceAtual = 0;
  List<Widget> telas = const [Inicio(), Lista(), Quiz()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text("App com Abas"),
        backgroundColor: Colors.orange[200],
      ),
      body: telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indiceAtual,
          onTap: (indice) {
            setState(() {
              _indiceAtual = indice;
            });
          },
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.orange[200],
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.house_siding_outlined), label: "Inicio"),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Lista"),
            BottomNavigationBarItem(
                icon: Icon(Icons.question_mark), label: "Lista"),
          ]),
    );
  }
}
