import 'package:flutter/material.dart';

class DefinirSenha extends StatefulWidget {
  @override
  _DefinirSenhaState createState() => _DefinirSenhaState();
}

class _DefinirSenhaState extends State<DefinirSenha> {
  String _senha = '';
  String? _questionarioSelecionado;
  int? _hoveredIndex;
  final TextEditingController _senhaController = TextEditingController();

  bool get _isSalvarEnabled {
    return _questionarioSelecionado != null && _senha.length >= 8;
  }

  void _showSenhaSalvaDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sucesso"),
          content: Text("Senha salva!"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _senha = '';
                  _senhaController.clear();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Erro"),
          content: Text(
              "Escolha um questionário e digite uma senha com pelo menos 8 caracteres."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Definir Senha'),
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
              "Defina uma senha para os questionários, elas devem ter pelo menos 8 caracteres!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Image.asset(
                'lib/app/images/cadeado.png',
                width: 200,
                height: 200,
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  hint: Text(
                    "Escolha um questionário",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  value: _questionarioSelecionado,
                  onChanged: (String? novoValor) {
                    setState(() {
                      _questionarioSelecionado = novoValor;
                    });
                  },
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  dropdownColor: Colors.purple,
                  underline: SizedBox(),
                  isExpanded: true,
                  items: <String>[
                    'Questionário Saúde da família',
                    'Questionário Educação',
                    'Questionário Odontologia',
                  ].asMap().entries.map((entry) {
                    int index = entry.key;
                    String valor = entry.value;
                    return DropdownMenuItem<String>(
                      value: valor,
                      child: MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _hoveredIndex = index;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _hoveredIndex = null;
                          });
                        },
                        child: Text(
                          valor,
                          style: TextStyle(
                            color: _hoveredIndex == index
                                ? Colors.blue
                                : Colors.white,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Digite a senha',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            TextField(
              controller: _senhaController,
              obscureText: true,
              onChanged: (valor) {
                setState(() {
                  _senha = valor;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Senha',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSalvarEnabled
                  ? () {
                      _showSenhaSalvaDialog();
                    }
                  : _showErrorDialog,
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
