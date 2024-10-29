import 'package:flutter/material.dart';
import 'dart:math';

class GerarLink extends StatefulWidget {
  @override
  _GerarLinkState createState() => _GerarLinkState();
}

class _GerarLinkState extends State<GerarLink> {
  String? _questionarioSelecionado;
  String _linkGerado = '';
  bool _linkGeradoVisivel = false;

  bool get _isGerarEnabled {
    return _questionarioSelecionado != null;
  }

  String _gerarLinkAleatorio() {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(10, (index) => chars[Random().nextInt(chars.length)]).join();
  }

  void _gerarLink() {
    setState(() {
      _linkGerado = 'https://compartilhar.com/link/' + _gerarLinkAleatorio();
      _linkGeradoVisivel = true;
    });
  }

  void _copiarLink() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Link copiado com sucesso")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerar Link'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[800]!, Colors.purple[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Selecione um questionário para gerar link de compartilhamento:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Image.asset(
                'lib/app/images/gerar.png',
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                hint: Text(
                  "Escolha um questionário",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                value: _questionarioSelecionado,
                onChanged: (String? novoValor) {
                  setState(() {
                    _questionarioSelecionado = novoValor;
                  });
                },
                style: TextStyle(color: Colors.white, fontSize: 16),
                dropdownColor: Colors.purple,
                underline: SizedBox(),
                isExpanded: true,
                items: <String>[
                  'Questionário Saúde da família',
                  'Questionário Educação',
                  'Questionário Odontologia',
                ].map((String valor) {
                  return DropdownMenuItem<String>(
                    value: valor,
                    child: Text(valor),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isGerarEnabled ? _gerarLink : null,
              child: Text("Gerar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
            ),
            if (_linkGeradoVisivel) ...[
              SizedBox(height: 20),
              SelectableText(
                _linkGerado,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _copiarLink,
                child: Text("Copiar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
