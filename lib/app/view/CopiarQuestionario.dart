import 'package:flutter/material.dart';

class CopiarQuestionario extends StatefulWidget {
  @override
  _CopiarQuestionarioState createState() => _CopiarQuestionarioState();
}

class _CopiarQuestionarioState extends State<CopiarQuestionario> {
  String? _questionarioSelecionado;
  int? _hoveredIndex;

  void _showQuestionarioCopiadoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sucesso"),
          content: Text("Questionário copiado com sucesso!"),
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
        title: Text('Copiar Questionário'),
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
              "Selecione um questionário para copiar:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16), 
            Center(
              child: Image.asset(
                'lib/app/images/caderneta.png',
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
              onPressed: () {
                _showQuestionarioCopiadoDialog();
              },
              child: Text("COPIAR"),
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

//Um questão que precisamos corrigir é que o botão "Copiar Questionário" 
//só poderá funcionar se o usuário escolher alguma opção do menu