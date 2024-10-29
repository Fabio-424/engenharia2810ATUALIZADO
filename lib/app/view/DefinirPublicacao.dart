import 'package:flutter/material.dart';

class DefinirPublicacao extends StatefulWidget {
  @override
  _DefinirPublicacaoState createState() => _DefinirPublicacaoState();
}

class _DefinirPublicacaoState extends State<DefinirPublicacao> {
  String? _questionarioSelecionado;
  String? _modoVisualizacaoSelecionado;

  bool get _isSalvarEnabled {
    return _questionarioSelecionado != null && _modoVisualizacaoSelecionado != null;
  }

  void _salvarConfiguracao() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Modo de visualização do questionário salvo")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Definir Publicação'),
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Escolha qual questionário terá visualização alterada:",
              style: TextStyle(color: Colors.white),
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
                  style: TextStyle(color: Colors.white),
                ),
                value: _questionarioSelecionado,
                onChanged: (String? novoValor) {
                  setState(() {
                    _questionarioSelecionado = novoValor;
                    _modoVisualizacaoSelecionado = null;
                  });
                },
                dropdownColor: Colors.purple,
                style: TextStyle(color: Colors.white),
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
            if (_questionarioSelecionado != null) ...[
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  hint: Text(
                    "Escolha o modo de visualização do questionário",
                    style: TextStyle(color: Colors.white),
                  ),
                  value: _modoVisualizacaoSelecionado,
                  onChanged: (String? novoValor) {
                    setState(() {
                      _modoVisualizacaoSelecionado = novoValor;
                    });
                  },
                  dropdownColor: Colors.purple,
                  style: TextStyle(color: Colors.white),
                  underline: SizedBox(),
                  isExpanded: true,
                  items: <String>['Público', 'Privado'].map((String valor) {
                    return DropdownMenuItem<String>(
                      value: valor,
                      child: Text(valor),
                    );
                  }).toList(),
                ),
              ),
            ],
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSalvarEnabled ? _salvarConfiguracao : null,
              child: Text("Salvar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
