import 'package:flutter/material.dart';

class ListaContatosPage extends StatelessWidget {
  const ListaContatosPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final List<Map<String,dynamic>> contatos =[
      {
        'iniciais':'PV',
        'cor': const Color(0xFF797979),
        'nome': 'Paulo Vitor',
        'telefone': '(14) 99776-7555',
        'favorito': true
      },
      {
        'iniciais':'BL',
        'cor':const Color(0xFF000000),
        'nome': 'Bruno Lima',
        'telefone': '(14) 99123-4567',
        'favorito': false,
      },
      {
        'iniciais':'CM',
        'cor':const Color(0xFFf26e22),
        'nome': 'Carla Mendes',
        'telefone': '(21) 997654-3210',
        'favorito': false,
      },
      {
        'iniciais':'AS',
        'cor':const Color(0xFF0018b5),
        'nome': 'Ana Souza',
        'telefone': '(11) 98765-4321',
        'favorito': true,
      },
      {
        'iniciais':'ET',
        'cor':const Color(0xFFa020f0),
        'nome': 'Elisa Torres',
        'telefone': '(17) 99999-5678',
        'favorito': false,
      },
    ];
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
                style: TextStyle(
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