import 'package:flutter/material.dart';

class ExcluirQuestionario extends StatefulWidget {
  @override
  _ExcluirQuestionarioState createState() => _ExcluirQuestionarioState();
}

class _ExcluirQuestionarioState extends State<ExcluirQuestionario> {
  String? _questionarioSelecionado;
  int? _hoveredIndex;

  void _showConfirmacaoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmação"),
          content: Text("Tem certeza que deseja excluir o questionário?"),
          actions: [
            TextButton(
              child: Text("Não"),
              onPressed: () {
                Navigator.of(context).pop(); // Corrigido com ;
              },
            ),
            TextButton(
              child: Text("Sim"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo de confirmação
                _showQuestionarioExcluidoDialog(); // Mostra o diálogo de sucesso
              },
            ),
          ],
        );
      },
    );
  }

  void _showQuestionarioExcluidoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sucesso"),
          content: Text("Questionário excluído com sucesso!"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Corrigido com 'Navigator'
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
        title: Text('Excluir Questionário'),
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
              "Selecione um questionário para excluir:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16), 
            Center(
              child: Image.asset(
                'lib/app/images/lixeira.png',
                width: 200,
                height: 200,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                hint: Text(
                  "Questionários Criados",
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
                  'Questionário Saúde da Família',
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
            SizedBox(height: 28),
            ElevatedButton(
              onPressed: _questionarioSelecionado != null ? _showConfirmacaoDialog : null,
              child: Text("EXCLUIR"),
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
