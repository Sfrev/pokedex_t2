import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pokedex_t2/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pokedex_t2/sfrevao.dart';
import 'package:pokedex_t2/instrucoes.dart';
import 'package:pokedex_t2/sfrevinho.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyAppScreen(),
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}

class MyAppScreen extends StatefulWidget {
  const MyAppScreen({super.key});

  @override
  State<MyAppScreen> createState() => _MyAppScreen();
}

class _MyAppScreen extends State<MyAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Pokedex',
            style: TextStyle(
              fontFamily: 'pokemons',
              color: Colors.yellow,
              fontSize: 50,
            ),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            child: Text(
              AppLocalizations.of(context)!.completePokedex,
              style: const TextStyle(fontFamily: 'pokemons'),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Greeting()),
              );
            },
          ),
          ElevatedButton(
            child: Text(
              AppLocalizations.of(context)!.yourPokemons,
              style: const TextStyle(fontFamily: 'pokemons'),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Greeting2()),
              );
            },
          ),
          ElevatedButton(
            child: Text(
              AppLocalizations.of(context)!.instructions,
              style: const TextStyle(fontFamily: 'pokemons'),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Instrucoes()),
              );
            },
          ),
        ],
      ),
    );
  }
}
