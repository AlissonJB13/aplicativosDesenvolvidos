import 'package:flutter/material.dart';

//informaçoes do app (desenvolvedores...)
class Sobre extends StatefulWidget {
  const Sobre({super.key});

  @override
  State<Sobre> createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 04, 82, 37),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text("Sobre"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Sobre"),
          ],
        ),
      ),
    );
  }
}
