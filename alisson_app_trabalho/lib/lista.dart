import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:alisson_app_trabalho/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Lista extends StatefulWidget {
  const Lista({super.key});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  List _listaPokemons = [];
  Map<String, dynamic> _ultimoPokemon = Map();
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerDescricao = TextEditingController();

  Future<File> _getArquivo() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json");
  }

  _salvarPokemon() {
    String nomeDigitado = _controllerNome.text;
    String descricaoDigitada = _controllerDescricao.text;
    Map<String, dynamic> pokemon = Map();

    pokemon["titulo"] = nomeDigitado;
    pokemon["texto"] = descricaoDigitada;
    pokemon["tenho"] = false;

    setState(() {
      _listaPokemons.add(pokemon);
    });
    _salvarArquivo();
    _controllerNome.text = "";
    _controllerDescricao.text = "";
  }

  _salvarArquivo() async {
    var arquivo = await _getArquivo();
    String dados = json.encode(_listaPokemons);
    arquivo.writeAsString(dados);
  }

  _lerArquivo() async {
    try {
      final arquivo = await _getArquivo();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  Widget criarItemLista(context, index) {
    return Dismissible(
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          _ultimoPokemon = _listaPokemons[index];
          _listaPokemons.removeAt(index);
          _salvarArquivo();
          final snackBar = SnackBar(
            duration: const Duration(seconds: 5),
            content: const Text("Pokemon Removido"),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                setState(() {
                  _listaPokemons.insert(index, _ultimoPokemon);
                  _salvarArquivo();
                });
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        background: Container(
          color: Colors.red,
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
              )
            ],
          ),
        ),
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        child: CheckboxListTile(
          title: Text(_listaPokemons[index]["titulo"]),
          subtitle: //Column(
              //children: [
              Text(_listaPokemons[index]["texto"]),
          //Text(_listaTarefas[index]["descricao"]),
          //],
          //),
          value: _listaPokemons[index]["tenho"],
          onChanged: (valorAlterado) {
            setState(() {
              _listaPokemons[index]["tenho"] = valorAlterado;
            });
            _salvarArquivo();
          },
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lerArquivo().then((dados) {
      setState(() {
        _listaPokemons = json.decode(dados);
      });
    });
  }

  /*void _voltarHome() {
    Navigator.pop(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }*/

  /*void _sair() {
    SystemNavigator.pop();
  }*/

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _listaPokemons.length, itemBuilder: criarItemLista),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Adicionar Pokémon Card"),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _controllerNome,
                        decoration:
                            const InputDecoration(labelText: "Digite o nome"),
                        onChanged: (text) {},
                      ),
                      TextFormField(
                        controller: _controllerDescricao,
                        decoration: const InputDecoration(
                            labelText: "Tipo, Ataque, Defesa"),
                        onChanged: (text) {},
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancelar")),
                  TextButton(
                      onPressed: () {
                        _salvarPokemon();
                        Navigator.pop(context);
                      },
                      child: const Text("Salvar"))
                ],
              );
            },
          );
        },
      ),
    );
  }
}
