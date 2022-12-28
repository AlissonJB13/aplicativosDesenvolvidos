import 'dart:io';

import 'package:bio_if/postagem.dart';
import 'package:bio_if/sobre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'ajuda.dart';

/*cadastro das especies
  -nome conhecido da especies
  -descricao
  -tipo
  -data
  -localização
  -foto
  -likes e deslikes
  -usuario que publicou
*/
class Especies extends StatefulWidget {
  const Especies({super.key});

  @override
  State<Especies> createState() => _EspeciesState();
}

class _EspeciesState extends State<Especies> {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerDescricao = TextEditingController();
  String? _campoSelecionado = "";
  String _resultado = "";
  XFile? _arquivoImagem;
  DateTime dataHora = DateTime.now();
  var db = FirebaseFirestore.instance;
  String? _urlImagem = null;
  String? _status = "Postagem não realizada";

  Future _capturaFoto(bool daCamera) async {
    final ImagePicker picker = ImagePicker();
    XFile? imagem;

    if (daCamera) {
      imagem = await picker.pickImage(source: ImageSource.camera);
    } else {
      imagem = await picker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _arquivoImagem = imagem;
    });
  }

  void _selecao() {
    if (_campoSelecionado == "") {
      setState(() {
        _resultado = "Não Informado";
      });
    } else if (_campoSelecionado == 'P') {
      setState(() {
        _resultado = "Planta";
      });
    } else {
      setState(() {
        _resultado = "Animal";
      });
    }
  }

  Future _postagem() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo = pastaRaiz
        .child("fotos")
        .child(DateTime.now().millisecondsSinceEpoch.toString());

    UploadTask task = arquivo.putFile(File(_arquivoImagem!.path));

    task.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      if (taskSnapshot.state == TaskState.running) {
        setState(() {
          _status = "Realizando postagem";
        });
      } else if (taskSnapshot.state == TaskState.success) {
        _recuperarImagem(taskSnapshot);
        setState(() {
          _status = "Postagem realizada com sucesso";
        });
      }
    });
  }

  Future _recuperarImagem(TaskSnapshot taskSnapshot) async {
    String url = await taskSnapshot.ref.getDownloadURL();
    print("URL: $url");
    setState(() {
      _urlImagem = url;
    });

    _selecao();

    Postagem postagem = Postagem(
        nome: _controllerNome.text,
        descricao: _controllerDescricao.text,
        tipo: _resultado,
        dataHora: dataHora,
        foto: _urlImagem);

    db.collection("Postagem").add(postagem.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text("Cadastro de Espécies"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              //const Text("Cadastro de Espécies"),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Nome Popular",
                ),
                controller: _controllerNome,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Descrição",
                ),
                controller: _controllerDescricao,
              ),
              //Row(children: [
              const Text("Tipo da Espécie:"),
              RadioListTile(
                  title: const Text("Planta"),
                  value: "P",
                  groupValue: _campoSelecionado,
                  onChanged: (String? resultado) {
                    setState(() {
                      _campoSelecionado = resultado;
                    });
                  }),
              RadioListTile(
                  title: const Text("Animal"),
                  value: "A",
                  groupValue: _campoSelecionado,
                  onChanged: (String? resultado) {
                    setState(() {
                      _campoSelecionado = resultado;
                    });
                  }),
              const Text("Foto:"),
              _arquivoImagem != null
                  ? Image.file(
                      File(_arquivoImagem!.path),
                      fit: BoxFit.cover,
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.folder),
                    onPressed: () {
                      _capturaFoto(false);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: () {
                      _capturaFoto(true);
                    },
                  ),
                ],
              ),
              ElevatedButton(
                //tem que pegar a localização e a data
                onPressed: () {
                  _postagem();
                },
                child: const Text("Enviar"),
              ),
              Text(_status!),
            ],
          ),
        ),
      ),
    );
  }
}
