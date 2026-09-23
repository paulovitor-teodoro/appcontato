import 'package:appcontato/sobre_page.dart';
import 'package:flutter/material.dart';
import 'database_helper.dart';

class CadastroContatoPage extends StatefulWidget {
  final Map<String, dynamic>? contato;

  const CadastroContatoPage({
    super.key,
    this.contato,
  });

  @override
  State<CadastroContatoPage> createState() =>
      _CadastroContatoPageState();
}

class _CadastroContatoPageState
    extends State<CadastroContatoPage> {
  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();

  bool favorito = false;
  String categoriaSelecionada = 'Pessoal';

  // Carrega os dados quando estamos editando um contato
  @override
  void initState() {
    super.initState();

    if (widget.contato != null) {
      nomeController.text =
          widget.contato!['nome'] ?? '';

      telefoneController.text =
          widget.contato!['telefone'] ?? '';

      favorito =
          widget.contato!['favorito'] == 1;

      categoriaSelecionada =
          widget.contato!['categoria'] ?? 'Pessoal';
    }
  }

  // Abre o AlertDialog para selecionar a categoria
  void selecionarCategoria() {
    String categoriaTemporaria =
        categoriaSelecionada;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text(
                'Selecione a categoria',
              ),

              content:
                  DropdownButtonFormField<String>(
                initialValue:
                    categoriaTemporaria,
                decoration:
                    const InputDecoration(
                  labelText: 'Categoria',
                  border:
                      OutlineInputBorder(),
                  prefixIcon:
                      Icon(Icons.category),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Pessoal',
                    child: Text('Pessoal'),
                  ),
                  DropdownMenuItem(
                    value: 'Trabalho',
                    child: Text('Trabalho'),
                  ),
                  DropdownMenuItem(
                    value: 'Família',
                    child: Text('Família'),
                  ),
                ],
                onChanged: (valor) {
                  if (valor != null) {
                    setStateDialog(() {
                      categoriaTemporaria =
                          valor;
                    });
                  }
                },
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:
                      const Text('Cancelar'),
                ),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      categoriaSelecionada =
                          categoriaTemporaria;
                    });

                    Navigator.pop(context);
                  },
                  child:
                      const Text('Confirmar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Salva ou atualiza um contato
  Future<void> salvarContato() async {
    String nome =
        nomeController.text.trim();

    String telefone =
        telefoneController.text.trim();

    if (nome.isEmpty ||
        telefone.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Preencha nome e telefone',
          ),
        ),
      );

      return;
    }

    // Se não recebeu contato, é cadastro
    if (widget.contato == null) {
      await DatabaseHelper.inserirContato({
        'nome': nome,
        'telefone': telefone,
        'favorito':
            favorito ? 1 : 0,
        'categoria':
            categoriaSelecionada,
      });
    }

    // Se recebeu contato, é edição
    else {
      await DatabaseHelper
          .atualizarContato({
        'id': widget.contato!['id'],
        'nome': nome,
        'telefone': telefone,
        'favorito':
            favorito ? 1 : 0,
        'categoria':
            categoriaSelecionada,
      });
    }

    if (!mounted) return;

    FocusScope.of(context).unfocus();

    Navigator.pop(context);
  }

  // Libera os controllers da memória
  @override
  void dispose() {
    nomeController.dispose();
    telefoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // MENU LATERAL
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisAlignment:
                    MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.contacts,
                    color: Colors.white,
                    size: 45,
                  ),

                  SizedBox(height: 10),

                  Text(
                    'App Contatos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // CONTATOS
            ListTile(
              leading:
                  const Icon(Icons.contacts),
              title:
                  const Text('Contatos'),
              onTap: () {
                // Fecha o Drawer
                Navigator.pop(context);

                // Volta para a lista
                Navigator.pop(context);
              },
            ),

            // CADASTRAR CONTATO
            ListTile(
              leading: const Icon(
                Icons.person_add,
              ),
              title: const Text(
                'Cadastrar contato',
              ),
              onTap: () {
                // Já estamos na página,
                // então apenas fecha o menu
                Navigator.pop(context);
              },
            ),

            // SOBRE
            ListTile(
              leading: const Icon(
                Icons.info_outline,
              ),
              title:
                  const Text('Sobre'),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const SobrePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      // BARRA SUPERIOR
      appBar: AppBar(
        title: Text(
          widget.contato == null
              ? 'Cadastrar Contato'
              : 'Editar Contato',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      // CONTEÚDO
      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [

            // NOME
            TextField(
              controller:
                  nomeController,
              decoration:
                  const InputDecoration(
                labelText: 'Nome',
                border:
                    OutlineInputBorder(),
                prefixIcon:
                    Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 20),

            // TELEFONE
            TextField(
              controller:
                  telefoneController,
              keyboardType:
                  TextInputType.phone,
              decoration:
                  const InputDecoration(
                labelText: 'Telefone',
                border:
                    OutlineInputBorder(),
                prefixIcon:
                    Icon(Icons.phone),
              ),
            ),

            const SizedBox(height: 20),

            // CATEGORIA
            ListTile(
              leading: const Icon(
                Icons.category,
                color: Colors.blue,
              ),
              title:
                  const Text('Categoria'),
              subtitle: Text(
                categoriaSelecionada,
              ),
              trailing: const Icon(
                Icons.arrow_drop_down,
              ),
              shape:
                  RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius:
                    BorderRadius.circular(4),
              ),
              onTap:
                  selecionarCategoria,
            ),

            const SizedBox(height: 20),

            // FAVORITO
            SwitchListTile(
              title:
                  const Text('Favorito'),
              value: favorito,
              onChanged: (valor) {
                setState(() {
                  favorito = valor;
                });
              },
              secondary:
                  const Icon(Icons.star),
            ),

            const SizedBox(height: 30),

            // BOTÃO SALVAR
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    salvarContato,
                child: Text(
                  widget.contato == null
                      ? 'Salvar Contato'
                      : 'Salvar Alterações',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}