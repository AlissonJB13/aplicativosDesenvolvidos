import 'package:alisson_app_trabalho/quiz.dart';
import 'package:flutter/material.dart';

class Pergunta1 extends StatefulWidget {
  const Pergunta1({super.key});

  @override
  State<Pergunta1> createState() => _Pergunta1State();
}

class _Pergunta1State extends State<Pergunta1> {
  String? _escolhaUsuario = "";
  String? _resultado = "";
  //Image _imageWid;

  void _respostaUsuario() {
    if (_escolhaUsuario == "") {
      setState(() {
        _resultado = 'Selecione uma das opções';
      });
    } else if (_escolhaUsuario == "P") {
      setState(() {
        _resultado = "Alternativa Correta!!!!!!";
      });
    } else {
      setState(() {
        _resultado = "Errou!!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          title: Image.asset(
            'imagens/pokebola.png',
            height: 50,
          ),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: const Text(
              "Qual foi o primeiro Pokémon do Ash?",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: RadioListTile(
                title: const Text("Pikachu"),
                value: "P",
                groupValue: _escolhaUsuario,
                onChanged: (String? escolha) {
                  setState(() {
                    _escolhaUsuario = escolha;
                  });
                }),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: RadioListTile(
                title: const Text("Charmander"),
                value: "C",
                groupValue: _escolhaUsuario,
                onChanged: (String? escolha) {
                  setState(() {
                    _escolhaUsuario = escolha;
                  });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  onPressed: _respostaUsuario,
                  child: const Text("Responder"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Voltar"),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              _resultado!,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          /*Padding(
              padding: EdgeInsets.all(20),
              child: Image.asset("Imagens/acertou.png")),*/
        ]),
      ),
    );
  }
}
