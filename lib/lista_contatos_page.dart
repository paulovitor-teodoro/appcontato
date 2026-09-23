import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'cadastro_contato_page.dart';
import 'sobre_page.dart';

class ListaContatosPage extends StatefulWidget {
  const ListaContatosPage({super.key});

  @override
  State<ListaContatosPage> createState() => _ListaContatosPageState();
}

class _ListaContatosPageState extends State<ListaContatosPage> {
  List<Map<String, dynamic>> contatos = [{}];
  String filtroSelecionado = 'Todos';

  List<Map<String, dynamic>> get contatosFiltrados {
    if(filtroSelecionado == 'Favoritos') {
      return contatos.where((contato) => contato['favorito'] == 1).toList();
    }
    if(filtroSelecionado == 'Não Favoritos') {
      return contatos.where((contato) => contato['favorito'] == 0).toList();
    }
    return contatos;
  }

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

     body: Column(
  children: [
    Padding(
      padding: const EdgeInsets.all(12),
      child: DropdownButtonFormField<String>(
        initialValue: filtroSelecionado,
        decoration: const InputDecoration(
          labelText: 'Filtrar contatos',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.filter_list),
        ),
        items: const [
          DropdownMenuItem(
            value: 'Todos',
            child: Text('Todos os Contatos'),
          ),
          DropdownMenuItem(
            value: 'Favoritos',
            child: Text('Favoritos'),
          ),
          DropdownMenuItem(
            value: 'Não Favoritos',
            child: Text('Não Favoritos'),
          ),
        ],
        onChanged: (valor) {
          if (valor != null) {
            setState(() {
              filtroSelecionado = valor;
            });
          }
        },
      ),
    ),

    Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: contatosFiltrados.length,
        itemBuilder: (context, index) {
          final contato = contatosFiltrados[index];

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CadastroContatoPage(contato: contato),
                  ),
                );

                carregarContatos();
              },
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),

              leading: CircleAvatar(
                radius: 23,
                backgroundColor: Colors.blue,
                child: Text(
                  contato['nome'] != null && contato['nome'].isNotEmpty
                      ? contato['nome'][0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              title: Text(
                contato['nome'] ?? 'Sem Nome',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              subtitle: Row(
                children: [
                  Text(
                    contato['telefone'] ?? 'Sem Telefone',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    contato['categoria'] ?? 'Sem Categoria',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]
              ),
              trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(
      contato['favorito'] == 1
          ? Icons.star
          : Icons.star_border,
      color: contato['favorito'] == 1
          ? Colors.orange
          : Colors.grey,
      size: 28,
    ),

    IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: () {
        confirmarExclusao(contato);
      },
    ),
  ],
),
            ),
          );
        
        },
      ),
    ),
  ],
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

  void confirmarExclusao(Map<String, dynamic> contato) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Excluir contato'),

        content: Text(
          'Deseja realmente excluir ${contato['nome'] ?? 'este contato'}?',
        ),

        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),

          TextButton(
            onPressed: () async {
              await DatabaseHelper.excluirContato(
                contato['id'],
              );

              if (!mounted) return;

              Navigator.pop(context);

              carregarContatos();
            },
            child: const Text(
              'Excluir',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    },
  );
}
}