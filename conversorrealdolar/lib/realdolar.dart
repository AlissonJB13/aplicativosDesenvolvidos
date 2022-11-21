import 'package:flutter/material.dart';

class RealDolar extends StatefulWidget {
  const RealDolar({super.key});

  @override
  State<RealDolar> createState() => _RealDolarState();
}

class _RealDolarState extends State<RealDolar> {
  TextEditingController _controllerValor = TextEditingController();
  String? _campoSelecionado = "";
  String _resultado = "";

  void _converter() {
    double? _valor = double.tryParse(_controllerValor.text);

    if (_campoSelecionado == "" || _valor == null) {
      setState(() {
        _resultado = "Selecione uma opção ou digite um número válido.";
      });
    } else if (_campoSelecionado == 'R') {
      _valor = _valor / 5.18;

      setState(() {
        _resultado =
            ("O valor digitado equivale a: ${_valor!.toStringAsFixed(2)} Real(is)");
      });
    } else {
      _valor = _valor * 5.18;

      setState(() {
        _resultado =
            ("O valor digitado equivale a: ${_valor!.toStringAsFixed(2)} Dólar(es)");
      });
    }
  }

  void limparCampo() {
    _controllerValor.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversor de moedas"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Image.asset("images/dolarreal.png"),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              textAlign: TextAlign.justify,
              "Escolha a opção desejada e digite o valor no campo de texto",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //const Padding(
          //padding: EdgeInsets.only(top: 20),
          /*child:*/ RadioListTile(
              title: const Text("Dólar para Real"),
              value: "R",
              groupValue: _campoSelecionado,
              onChanged: (String? escolha) {
                setState(() {
                  _campoSelecionado = escolha;
                });
              }),
          /*child:*/ RadioListTile(
              title: const Text("Real para Dólar"),
              value: "D",
              groupValue: _campoSelecionado,
              onChanged: (String? escolha) {
                setState(() {
                  _campoSelecionado = escolha;
                });
              }),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _controllerValor,
              decoration: const InputDecoration(
                labelText: "Digite o valor aqui",
              ),
              style: const TextStyle(fontSize: 22),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.all(15)),
              onPressed: _converter,
              child: const Text(
                "Converter",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              _resultado,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
