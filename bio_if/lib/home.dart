import 'dart:developer';

import 'package:bio_if/cadastro.dart';
import 'package:bio_if/especies.dart';
import 'package:bio_if/postagem.dart';
import 'package:bio_if/sobre.dart';
import 'package:bio_if/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  //List<Object> _postagemLista = [];
  var db = FirebaseFirestore.instance;
  int count = 0;
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

  Future _like() async {
    setState(() {
      count++;
    });

    db.collection("Postagens").doc().update({"like": Counter});
  }

  Future _dislike() async {
    setState(() {
      count++;
    });

    db.collection("Postagens").doc().update({"dislike": Counter});
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
                          return Container(
                            height: 700,
                            width: double.infinity,
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.zero,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(2, 2),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(children: [
                              Container(
                                margin: const EdgeInsets.all(5),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  snap[index]['nome'],
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
                                  "${snap[index]['descricao']}",
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
                                      icon:
                                          const Icon(Icons.heart_broken_sharp)),
                                  Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        snap[index]['dislike'].toString(),
                                      )),
                                ],
                              ),
                            ]),
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
            ],
          ),
        ));
  }
}
