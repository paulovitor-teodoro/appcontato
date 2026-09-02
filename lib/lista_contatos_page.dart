import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'cadastro_contato_page.dart';

class ListaContatosPage extends StatefulWidget {
  const ListaContatosPage({super.key});

  @override
  State<ListaContatosPage> createState() => _ListaContatosPageState();
}

class _ListaContatosPageState extends State<ListaContatosPage> {
  List<Map<String, dynamic>> contatos = [];

  @override
  void initState() {
    super.initState();
    carregarContatos();
  }

  void carregarContatos() async {
    final dados = await DatabaseHelper.buscarContatos();

    setState(() {
      contatos = dados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meus Contatos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          final contato = contatos[index];

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),

              leading: CircleAvatar(
                radius: 23,
                backgroundColor: Colors.blue,
                child: Text(
                  contato['nome'][0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              title: Text(
                contato['nome'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              subtitle: Text(
                contato['telefone'],
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),

              trailing: Icon(
                contato['favorito'] == 1
                    ? Icons.star
                    : Icons.star_border,
                color: contato['favorito'] == 1
                    ? Colors.orange
                    : Colors.grey,
                size: 30,
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => adicionarContato(),
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  void adicionarContato() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CadastroContatoPage(),
      ),
    );

    carregarContatos();
  }
}