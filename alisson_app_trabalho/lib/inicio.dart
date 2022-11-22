import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Image.asset('imagens/lucario_ash.png'),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: const Text(
                "Informações ao Usuário",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: const Text(
                'Olá Treinador, seja bem vindo a Mini Pokédex. É um prazer ter você conosco nessa jornada e estamos aqui para auxília-lo com seus Pokémon Cards. Com o app você pode:',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: const Text(
                '- Organizar seus cards por Nome, Tipo, Ataque e Defesa;',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: const Text(
                '- Listar os Cards que você possui;',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: const Text(
                '- Listar os Cards que você ainda não têm;',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: const Text(
                '- Encontrar amigos para poder trocar seus Cards repetidos',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: const Text(
                '- Para acessar a lista basta arrastar para o lado ou clicar no botão "lista" na barra superior do app;',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: const Text(
                '- No botão "?" você consegue testar seus conhecimentos com um quiz sobre o Mundo Pokémon;',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: const Text(
                '- Se divirta e se precisar entre em contato conosco: gerpokedex@pokemonworld.com.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
