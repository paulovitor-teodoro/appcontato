import 'package:flutter/material.dart';

class ListaContatosPage extends StatelessWidget {
  const ListaContatosPage({super.key});

  final List<Map<String, dynamic>> contatos = const [
    {
      'nome': 'Ana Souza',
      'telefone': '(11) 98765-4321',
      'iniciais': 'AS',
      'cor': Colors.blue,
      'favorito': true,
    },
    {
      'nome': 'Bruno Lima',
      'telefone': '(14) 99123-4567',
      'iniciais': 'BL',
      'cor': Colors.blue,
      'favorito': false,
    },
    {
      'nome': 'Carla Mendes',
      'telefone': '(21) 97654-3210',
      'iniciais': 'CM',
      'cor': Colors.orange,
      'favorito': true,
    },
    {
      'nome': 'Diego Alves',
      'telefone': '(19) 98888-1234',
      'iniciais': 'DA',
      'cor': Colors.green,
      'favorito': false,
    },
    {
      'nome': 'Elisa Torres',
      'telefone': '(17) 99999-5678',
      'iniciais': 'ET',
      'cor': Colors.purple,
      'favorito': false,
    },
  ];

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
        backgroundColor: Colors.blue[800],
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
                backgroundColor: contato['cor'],
                child: Text(
                  contato['iniciais'],
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
                contato['favorito']
                    ? Icons.star
                    : Icons.star_border,
                color: contato['favorito']
                    ? Colors.orange
                    : Colors.grey,
                size: 30,
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}