import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper {
  static Database? _db;

  static Future<Database> get database async {
    _db ??= await abrirBanco();
    return _db!;
  }

  static Future<Database> abrirBanco() async {
    final caminho = join(
      await getDatabasesPath(),
      'contatos.db',
    );

    return openDatabase(
      caminho,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE contatos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            iniciais TEXT,
            cor INTEGER,
            nome TEXT,
            telefone TEXT,
            favorito INTEGER
          )
        ''');
      },
    );
  }

  static Future<List<Map<String, dynamic>>> buscarContatos() async {
    final db = await DatabaseHelper.database;

    return db.query('contatos');
  }

  static Future<void> inserirContato(
    Map<String, dynamic> contato,
  ) async {
    final db = await DatabaseHelper.database;

    await db.insert(
      'contatos',
      {
        'iniciais': contato['iniciais'],
        'cor': contato['cor'],
        'nome': contato['nome'],
        'telefone': contato['telefone'],
        'favorito': contato['favorito'] == 1 ? 1 : 0,
      },
    );
  }
}