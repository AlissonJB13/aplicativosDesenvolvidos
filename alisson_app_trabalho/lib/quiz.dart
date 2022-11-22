import 'package:flutter/material.dart';
import 'package:alisson_app_trabalho/pergunta1.dart';
import 'package:alisson_app_trabalho/pergunta2.dart';
import 'package:alisson_app_trabalho/pergunta3.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  void _pergunta1() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Pergunta1()));
  }

  void _pergunta2() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Pergunta2()));
  }

  void _pergunta3() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Pergunta3()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: /*Padding(
          padding: EdgeInsets.all(20),*/
            Center(
          child:
              Column(//mainAxisAlignment: MainAxisAlignment.center, children: [
                  children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Quiz Pokémon",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Teste seus conhecimentos sobre o Mundo Pokémon: selecione entre Bulbasaur, Charmander e Squirtle e responda a questão a seguir!!!",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: _pergunta1,
                child: Image.asset(
                  "imagens/bulba.png",
                  height: 200,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: _pergunta2,
                child: Image.asset(
                  "imagens/char.png",
                  height: 300,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: _pergunta3,
                child: Image.asset(
                  "imagens/squi.png",
                  height: 300,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
