import 'dart:async';
import 'dart:developer';

import 'package:bio_if/cadastro.dart';
import 'package:bio_if/especies.dart';
import 'package:bio_if/postagem.dart';
import 'package:bio_if/sobre.dart';
import 'package:bio_if/login.dart';
import 'package:bio_if/usuarioatual.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  var db = FirebaseFirestore.instance;
  String? _statusLogin = "";
  List<String> itensMenu = [
    "Login",
    "Cadastro",
    "Cadastro de Espécies",
    "Sobre",
    "Ajuda",
    "Sair"
  ];

  _escolhaMenuItem(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Login":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
        break;
      case "Cadastro":
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

  //nao ta funcionando
  Future _like() async {
    db.collection("Postagem").doc().update({"like": FieldValue.increment(1)});
  }

  //nao ta funcionando
  Future _dislike() async {
    db
        .collection("Postagem")
        .doc()
        .update({"dislike": FieldValue.increment(1)});
  }

  /*void usuarioLogado() {
    if (UsuarioAtual().currentUser!.email == null) {
      setState(() {
        _statusLogin = "Usuário não logado";
      });
    } else {
      setState(() {
        _statusLogin = "${UsuarioAtual().currentUser!.email}";
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 04, 82, 37),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: Text("Bio IF"),
          /*${UsuarioAtual().currentUser!.email}),*/
          /*Image.asset(
          'imagens/logo.png',
          height: 22,
        ),*/
          actions: [
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
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Postagem")
                      .orderBy("data e hora", descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final snap = snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snap.length,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            Container(
                              margin: const EdgeInsets.all(5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Usuário: ${snap[index]['nome usuario']}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Nome Popular: ${snap[index]['nome']}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Descrição: ${snap[index]['descricao']}",
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "${snap[index]['tipo']}",
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(20),
                              alignment: Alignment.center,
                              child: Image.network(
                                snap[index]['foto'],
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Data: ${snap[index]['data e hora']}",
                                )),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _like;
                                    },
                                    icon: const Icon(Icons.favorite)),
                                Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      snap[index]['like'].toString(),
                                    )),
                                IconButton(
                                    onPressed: _dislike,
                                    icon: const Icon(Icons.heart_broken_sharp)),
                                Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      snap[index]['dislike'].toString(),
                                    )),
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                              indent: 20,
                              endIndent: 20,
                            )
                          ]);
                        },
                      );
                    } else {
                      return const Padding(
                          padding: EdgeInsets.all(150),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ));
                    }
                  }),
            ],
          ),
        ));
  }
}
