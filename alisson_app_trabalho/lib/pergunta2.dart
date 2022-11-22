import 'package:flutter/material.dart';

class Pergunta2 extends StatefulWidget {
  const Pergunta2({super.key});

  @override
  State<Pergunta2> createState() => _Pergunta2State();
}

class _Pergunta2State extends State<Pergunta2> {
  String? _escolhaUsuario = "";
  String? _resultado = "";
  //Image _imageWid;

  void _respostaUsuario() {
    if (_escolhaUsuario == "") {
      setState(() {
        _resultado = 'Selecione uma das opções';
      });
    } else if (_escolhaUsuario == "G") {
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
              "Qual é a evolução do Magikarp?",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: RadioListTile(
                title: const Text("Gyarados"),
                value: "G",
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
                title: const Text("Snorlax"),
                value: "S",
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
