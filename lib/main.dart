import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget { //caracteristicas que nao mudam
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( 
      create: (context) => MyAppState(),
        child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 205, 25, 25)),
          
        ),
        home: MyHomePage(),
      ),
    );
  }
}


class MyAppState extends ChangeNotifier{
  var current = WordPair.random();

  void getNext(){
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('A random ideia'),
            BigCard(pair: pair),
            SizedBox(height: 10,)
            ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text('Next'),
            )  
          ],
        ),
      )
    );
  }
  
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.
      copyWith(color: theme.colorScheme.onPrimary);

    return Center(
      child: Card(
        color: theme.colorScheme.primary,
        child: Padding( //para dar espaço la de cima
          padding: const EdgeInsets.all(20.0),
          child: Text(pair.asPascalCase, style: style,semanticsLabel: "${pair.first} ${pair.second}",), //ativar leitura do campo
        ),
      ),
    );
  }
}
