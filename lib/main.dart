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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                    MaterialPageRoute(
                        builder: (context) => const ComputerGame(
                              title: 'Spiel gegen den Computer',
                            )));
              },
              icon: const Icon(
                Icons.computer,
                size: 150,
              ),
              tooltip: 'Spiel gegen den Computer',
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HotSeatGame(
                          title: 'Hot-Seat Spiel',
                        )));
              },
              icon: const Icon(
                Icons.chair,
                size: 150,
              ),
              tooltip: 'Hot-Seat Spiel gegen anderen Spieler',
            ),
            IconButton(
              onPressed: _nothing,
              icon: const Icon(
                Icons.people,
                size: 150,
              ),
              tooltip: 'Onlinespiel gegen andere Spieler',
            ),
          ],
        ),
      ),
    );
  }
}

class HotSeatGame extends StatefulWidget {
  const HotSeatGame({super.key, required this.title});

  final String title;

  @override
  State<HotSeatGame> createState() => _HotSeatGameState();
}

class _HotSeatGameState extends State<HotSeatGame> {
  String userinput = "";
  String user2input = "";
  List<String> _input = ["scissor", "stone", "paper"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("\nSpieler ${userinput.isEmpty ? "1" : (user2input.isEmpty? "2" : "1")},\nwähle deine Waffe!", style: TextStyle(fontSize: 25.0)),
            GameButton(id: _input[0]),
            GameButton(id: _input[1]),
            GameButton(id: _input[2]),
            Text(_returnFight(), style: const TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }

  String _returnFight() {
    String result = user2input.isEmpty ? "" : "Spieler 1 hat ";

    if (user2input.isNotEmpty)
    switch (userinput) {
      case "scissor":
        result += "Schere";
        break;
      case "stone":
        result += "Stein";
        break;
      case "paper":
        result += "Papier";
        break;
      default:
        result += "";
    }

    result += user2input.isEmpty ? "" : " gewählt!\n";
    result += user2input.isEmpty ? "" : "Spieler 2 hat ";

    switch (user2input) {
      case "scissor":
        result += "Schere";
        break;
      case "stone":
        result += "Stein";
        break;
      case "paper":
        result += "Papier";
        break;
      default:
        result += "";
    }

    result += user2input.isEmpty ? "" : " gewählt!\n";

    if (user2input.isNotEmpty){
      if (userinput == 'scissor') {
        if (user2input == "stone") result += "Spieler 2 hat gewonnen!";
        else if (user2input == "paper") result += "Spieler 1 hat gewonnen!";
        else result += "Unentschieden!";
      }

      if (userinput == 'paper') {
        if (user2input == "stone") result += "Spieler 1 hat gewonnen!";
        else if (user2input == "paper") result += "Unentschieden!";
        else result += "Spieler 2 hat gewonnen!";
      }

      if (userinput == 'stone') {
        if (user2input == "stone") result += "Unentschieden!";
        else if (user2input == "paper") result += "Spieler 2 hat gewonnen!";
        else result += "Spieler 1 hat gewonnen!";
      }
    }

    if (userinput.isNotEmpty && user2input.isNotEmpty) {
      userinput = "";
      user2input = "";
    }
    return result;
  }

  IconButton GameButton({required String id}) {
    final String img;
    final String tip;

    switch (id) {
      case 'scissor':
        img = "assets/images/scissors.png";
        tip = "Schere";
        break;
      case 'paper':
        img = "assets/images/hand-paper.png";
        tip = "Papier";
        break;
      case 'stone':
        img = "assets/images/raise-hand.png";
        tip = "Stein";
        break;
      default:
        img = "";
        tip = "";
    }
    return IconButton(
      onPressed: () {
        setState(() {
          if (userinput.isEmpty) userinput = id;
          else user2input = id;
          _input.shuffle();
        });
      },
      icon: ImageIcon(
          AssetImage(img),
          size: 150
      ),
      tooltip: tip,
    );
  }
}

class ComputerGame extends StatefulWidget {
  const ComputerGame({super.key, required this.title});

  final String title;

  @override
  State<ComputerGame> createState() => _ComputerGameState();
}

class _ComputerGameState extends State<ComputerGame> {
  String userinput = "";
  String cpuinput = "";
  final List<String> _input = ["scissor", "stone", "paper"];
  var rng = Random();

  String _returnFight() {
    String result = userinput.isEmpty ? "" : "Du hast ";
    cpuinput = _input[rng.nextInt(3)];
    switch (userinput) {
      case "scissor":
        result += "Schere";
        break;
      case "stone":
        result += "Stein";
        break;
      case "paper":
        result += "Papier";
        break;
      default:
        result += "";
    }

    result += userinput.isEmpty ? "" : " gewählt!\nDein Kontrahent hat ";

    switch (cpuinput) {
      case "scissor":
        result += "Schere";
        break;
      case "stone":
        result += "Stein";
        break;
      case "paper":
        result += "Papier";
        break;
      default:
        result += "";
    }

    result += userinput.isEmpty ? "" : " gewählt!\n";

    if (userinput == 'scissor') {
      if (cpuinput == "stone") result += "Du hast verloren!";
      else if (cpuinput == "paper") result += "Du hast gewonnen!";
      else result += "Unentschieden!";
    }

    if (userinput == 'paper') {
      if (cpuinput == "stone") result += "Du hast gewonnen!";
      else if (cpuinput == "paper") result += "Unentschieden!";
      else result += "Du hast verloren!";
    }

    if (userinput == 'stone') {
      if (cpuinput == "stone") result += "Unentschieden!";
      else if (cpuinput == "paper") result += "Du hast verloren!";
      else result += "Du hast gewonnen!";
    }
    if (userinput.isNotEmpty && cpuinput.isNotEmpty) {
      userinput = "";
      cpuinput = "";
    }
    return result;
  }

  IconButton GameButton({required String id}) {
    final String img;
    final String tip;
    switch (id) {
      case 'scissor':
        img = "assets/images/scissors.png";
        tip = "Schere";
        break;
      case 'paper':
        img = "assets/images/hand-paper.png";
        tip = "Papier";
        break;
      case 'stone':
        img = "assets/images/raise-hand.png";
        tip = "Stein";
        break;
      default:
        img = "";
        tip = "";
    }
    return IconButton(
      onPressed: () {
        setState(() {
          if (userinput.isEmpty) userinput = id;
        });
      },
      icon: ImageIcon(
          AssetImage(img),
          size: 150
      ),
      tooltip: tip,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("\nWähle deine Waffe!", style: TextStyle(fontSize: 25.0)),
            GameButton(id: 'scissor'),
            GameButton(id: 'paper'),
            GameButton(id: 'stone'),
            Text(_returnFight(), style: const TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}
