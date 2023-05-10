import 'package:flutter/material.dart';
import 'package:cadastros_contatos/database/database_helper%20subs.dart';
import 'package:flutter_application_1/database_helper.dart';

void main() => runApp(const MyApp());
class MyApp extends StatelessWidget { //caracteristicas que nao mudam
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
        title: 'SQFlite Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
class MyHomePage extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: text('Exemplo de CRUD basico'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Inserir dados', style: TextStyle(fontSize: 20),),
              onPressed: () {_inserir();},
            )
            ElevatedButton(
              child: Text('Consultar dados', style: TextStyle(fontSize: 20),),
              onPressed: () {_consultar();},
            )
            ElevatedButton(
              child: Text('Atualizar dados', style: TextStyle(fontSize: 20),),
              onPressed: () {_atualizar();},
            )
            ElevatedButton(
              child: Text('Deletar dados', style: TextStyle(fontSize: 20),),
              onPressed: () {_deletar();},
            ),
          ],
        ),
      ),
    );
  }

  void _inserir() async{
    Map<String, dynamic> row = {
      DatabaseHelper.columnNome: 'Joao inserir',
      DatabaseHelper.columnIdade: 40
    };
    final id = await dbHelper.insert(row);
    print('linha inserida id: $id');
  }

  void _consultar() async {
    final todasLinhas = await dbHelper.queryAllRows();
    print('Consulta todas as linhas:');
    todasLinhas.forEach((row) => print(row));
  }

  void _atualizar() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId : 1,
      DatabaseHelper.columnNome : 'Maria atualizar',
      DatabaseHelper.columnIdade : 32
    };
    final linhasAfetas = await dbHelper.update(row);
    print('atualizados $linhasAfetas linha(s)');
  }
  void _deletar() async{
    final id = await dbHelper.queryRowCount();
    final linhaDeletada = away dbHelper.delete(id!);
    print('Deletada(s) $linhaDeletada linha(s): linha $id');
  }
}

