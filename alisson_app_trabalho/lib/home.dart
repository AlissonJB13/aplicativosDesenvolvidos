import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'adicionar.dart';
import 'inicio.dart';
import 'lista.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  //inicializar o tabcontroller this vai remeter ao singletickerprovider
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // liberar memoria
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController?.dispose();
  }

  void _irLista() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Lista()));
  }

  void _sair() {
    SystemNavigator.pop();
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
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 2,
            labelStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            controller: _tabController,
            tabs: const [
              Tab(
                //text: "Cadastro",
                icon: Icon(Icons.house_siding_outlined),
              ),
              Tab(
                //text: "Visualizar",
                icon: Icon(Icons.list_alt),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: _sair,
              icon: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: const [
        Inicio(),
        Lista(),
      ]),
    );
  }
}
