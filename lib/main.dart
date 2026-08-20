import 'package:flutter/material.dart';
import 'lista_contatos_page.dart';

void main() {
  runApp(const AppContato());
}

class AppContato extends StatelessWidget {
  const AppContato({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meus Contatos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListaContatosPage(),
    );
  }
}