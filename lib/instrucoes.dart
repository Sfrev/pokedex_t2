import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Instrucoes extends StatelessWidget {
  const Instrucoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.instructions)),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.instructionsText,
            textAlign: TextAlign.justify,
            style: const TextStyle(
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
