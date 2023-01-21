import 'package:flutter/material.dart';

//instruçoes do app

class Ajuda extends StatefulWidget {
  const Ajuda({super.key});

  @override
  State<Ajuda> createState() => _AjudaState();
}

class _AjudaState extends State<Ajuda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 04, 82, 37),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text("Ajuda"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Ajuda"),
          ],
        ),
      ),
    );
  }
}
