import 'package:flutter/material.dart';
import 'database_helper.dart';

class CadastroContatoPage extends StatefulWidget {
  const CadastroContatoPage({super.key});

  @override
  State<CadastroContatoPage> createState() => _CadastroContatoPageState();
}

class _CadastroContatoPageState extends State<CadastroContatoPage> {
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();

  bool favorito = false;

  void salvarContato() async {
    String nome = nomeController.text;
    String telefone = telefoneController.text;

    if (nome.isEmpty || telefone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha nome e telefone'),
        ),
      );
      return;
    }

    await DatabaseHelper.inserirContato({
      'nome': nome,
      'telefone': telefone,
      'favorito': favorito ? 1 : 0,
    });

    Navigator.pop(context);
  }

  @override
  void dispose() {
    nomeController.dispose();
    telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastrar Contato',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: telefoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Telefone',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 20),

            SwitchListTile(
              title: const Text('Favorito'),
              value: favorito,
              onChanged: (valor) {
                setState(() {
                  favorito = valor;
                });
              },
              secondary: const Icon(Icons.star),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: salvarContato,
                child: const Text('Salvar Contato'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}