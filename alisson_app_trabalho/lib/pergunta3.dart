import 'package:flutter/material.dart';

class Pergunta3 extends StatefulWidget {
  const Pergunta3({super.key});

  @override
  State<Pergunta3> createState() => _Pergunta3State();
}

class _Pergunta3State extends State<Pergunta3> {
  String? _escolhaUsuario = "";
  String? _resultado = "";
  //Image _imageWid;

  void _respostaUsuario() {
    if (_escolhaUsuario == "") {
      setState(() {
        _resultado = 'Selecione uma das opções';
      });
    } else if (_escolhaUsuario == "EPL") {
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
              "Qual as maiores fraquezas de um Pokémon tipo água?",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: RadioListTile(
                title: const Text("Fogo e Pedra"),
                value: "FPE",
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
                title: const Text("Elétrico e Planta"),
                value: "EPL",
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
