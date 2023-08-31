import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokedex_t2/poke_screen.dart';
import 'package:pokedex_t2/sfrevao.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  // runApp(const PokemonScreenApp(id: 1));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: const MyAppScreen(),
      // home: const PokemonScreenApp(id: 1),
    );
  }
}

class MyAppScreen extends StatefulWidget {
  const MyAppScreen({super.key});

  @override
  State<MyAppScreen> createState() => _MyAppScreen();
}

class _MyAppScreen extends State<MyAppScreen> {
  // const MyAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Here'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          const Text('Pokedex', style: TextStyle(fontFamily: 'pokemons', color: Colors.yellow, fontSize: 50),textAlign: TextAlign.center,),
          ElevatedButton(
            child: const Text('Pokedex Completa', style: TextStyle(fontFamily: 'pokemons'),),
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Greeting()));
            },
          ),
          ElevatedButton(
            child: const Text('Seus Pokemons', style: TextStyle(fontFamily: 'pokemons'),),
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Greeting()));
            },
          ),
          ElevatedButton(
            child: const Text('Instruções', style: TextStyle(fontFamily: 'pokemons'),),
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Greeting()));
            },
          ),
        ],
      ),
    );
  }
}
