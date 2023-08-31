import 'package:flutter/material.dart';

class Instrucoes extends StatelessWidget {
  const Instrucoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instruções'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(32.0),
        child: Center(
          child: Text(
            "Para utilizar é simples, na tela de pokedex completa você pode ver "
            "todos os pokemons e clicar no desejado, o que te destinará a outra "
            "tela, do pokémon selecionado lá você pode ver todos seus atributos "
            "e estatísticas, além de clicar no canto superior direito e definir "
            "esse pokémon como Wild (não visto / pego) ou Caught (Capturado)."
            "Na tela de pokemons capturados, você verá todos (e somente) os "
            "pokémons que você já capturou!! É bem simples!! Bom divertimento!! "
            "Gotta Catch'em All!!",
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'pokemons',
              color: Colors.black87,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
