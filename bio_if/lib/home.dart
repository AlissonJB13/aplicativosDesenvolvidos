import 'package:bio_if/cadastro.dart';
import 'package:bio_if/especies.dart';
import 'package:bio_if/postagem.dart';
import 'package:bio_if/sobre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ajuda.dart';

//listagem das especies
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Object> _postagemLista = [];
  var db = FirebaseFirestore.instance;

  List<String> itensMenu = [
    "Login / Cadastro de Usuário",
    "Cadastro de Espécies",
    "Sobre",
    "Ajuda",
    "Sair"
  ];

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Login / Cadastro de Usuário":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Cadastro()));
        break;
      case "Cadastro de Espécies":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Especies()));
        break;
      case "Sobre":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Sobre()));
        break;
      case "Ajuda":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Ajuda()));
        break;
      case "Sair":
        SystemNavigator.pop();
        break;
      default:
    }
  }

  //metodo para tentar mostrar a lista
  Future _Lista() async {
    QuerySnapshot snapshot = await db
        .collection("Postagem")
        .orderBy("data e hora", descending: false)
        .get();

    for (DocumentSnapshot doc in snapshot.docs) {
    var item = Postagem.fromDocument(doc);
    print(item.toString());
  }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text("Bio IF"),
        /*Image.asset(
          'imagens/logo.png',
          height: 22,
        ),*/
        actions: [
          /*IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Sobre()));
            },
            icon: const Icon(Icons.settings),
          ),*/
          PopupMenuButton(
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem(value: item, child: Text(item));
              }).toList();
            },
            onSelected: _escolhaMenuItem,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          //meu metodo nao esta funcionando
          _Lista();
        ],)
        ),
    );
  }
}
