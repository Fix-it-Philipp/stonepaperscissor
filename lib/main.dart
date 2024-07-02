import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stein-Schere-Papier',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Stein-Schere-Papier'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _nothing() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ComputerGame(title: 'Spiel gegen den Computer',)));
                },
              icon: Icon(Icons.computer, size: 100,),
              tooltip: 'Spiel gegen den Computer',
            ),
            IconButton(
              onPressed: _nothing,
              icon: Icon(Icons.chair, size: 100,),
              tooltip: 'Hot-Seat Spiel gegen anderen Spieler',
            ),
            IconButton(
              onPressed: _nothing,
              icon: Icon(Icons.people, size: 100,),
              tooltip: 'Onlinespiel gegen andere Spieler',
            ),
          ],
        ),
      ),
    );
  }
}


class ComputerGame extends StatefulWidget {
  const ComputerGame({super.key, required this.title});

  final String title;

  @override
  State<ComputerGame> createState() => _ComputerGameState();
}

class _ComputerGameState extends State<ComputerGame>{
  String userinput = "";
  String cpuinput = "";
  final List<String> _input = ["scissor", "stone", "paper"];
  var rng = Random();

  _fight({required String userinput}) {
    setState(() {
      this.userinput = userinput;
      cpuinput = _input[rng.nextInt(3)];
    });
  }

  String _returnFight() {
    String result = "";

    if (userinput == 'scissor') {
      if (cpuinput == "stone")
        result = "Dein Kontrahent hat Stein gewählt!\nDu hast verloren!";
      else if (cpuinput == "paper")
        result = "Dein Kontrahent hat Papier gewählt!\nDu hast gewonnen!";
      else
        result = "Dein Kontrahent hat Schere gewählt!\nEs ist unentschieden!";
    };

    if (userinput == 'paper') {
      if (cpuinput == "stone")
        result = "Dein Kontrahent hat Stein gewählt!\nDu hast gewonnen!";
      else if (cpuinput == "paper")
        result = "Dein Kontrahent hat Papier gewählt!\nEs ist unentschieden!";
      else
        result = "Dein Kontrahent hat Schere gewählt!\nDu hast verloren!";
    };

    if (userinput == 'stone') {
      if (cpuinput == "stone")
        result = "Dein Kontrahent hat Stein gewählt!\nEs ist unentschieden!";
      else if (cpuinput == "paper")
        result = "Dein Kontrahent hat Papier gewählt!\nDu hast verloren!";
      else
        result = "Dein Kontrahent hat Schere gewählt!\nDu hast gewonnen!";
    };

  return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Wähle deine Waffe!"),
              IconButton(
                icon: const Icon(Icons.content_cut, size: 100),
                tooltip: "Schere",
                onPressed: () { setState(() {_fight(userinput: 'scissor');});},
              ),
              IconButton(
                onPressed: () { setState(() {_fight(userinput: 'paper');});},
                icon: const Icon(Icons.newspaper, size: 100),
                tooltip: "Papier",
              ),
              IconButton(
                onPressed: () { setState(() {_fight(userinput: 'stone');});},
                icon: const Icon(Icons.monitor_weight, size: 100),
                tooltip: "Stein",
              ),
              Text(_returnFight()),
            ],
        ),
      ),
    );
  }
  
}










