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
      version: 2,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE contatos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            iniciais TEXT,
            cor INTEGER,
            nome TEXT,
            telefone TEXT,
            favorito INTEGER
            categoria TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          db.execute('''
            ALTER TABLE contatos ADD COLUMN categoria TEXT
          ''');
        }
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
      'nome': contato['nome'],
      'telefone': contato['telefone'],
      'favorito': contato['favorito'],
    },
  );
}

static Future<void> excluirContato(int id) async {
  final db = await DatabaseHelper.database;

  await db.delete(
    'contatos',
    where: 'id = ?',
    whereArgs: [id],
  );
}

  static Future<void> atualizarContato(
  Map<String, dynamic> contato,
) async {
  final db = await DatabaseHelper.database;

  await db.update(
    'contatos',
    {
      'nome': contato['nome'],
      'telefone': contato['telefone'],
      'favorito': contato['favorito'],
      'categoria': contato['categoria'],
    },
    where: 'id = ?',
    whereArgs: [contato['id']],
  );
 }
}