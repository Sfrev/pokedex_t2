import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pokedex_t2/poke_api.dart';
import 'package:pokedex_t2/poke_screen.dart';

class CardTitle extends StatelessWidget {
  final String pokemonName;

  const CardTitle({required this.pokemonName, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      pokemonName,
      maxLines: 1,
    );
  }
}

String titleCase(String s) {
  return '${s[0].toUpperCase()}${s.substring(1).toLowerCase()}';
}

class CardTypeColumnItem extends StatelessWidget {
  final String ty;

  const CardTypeColumnItem({super.key, required this.ty});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 60),
          child: Center(child: Text(titleCase(ty))),
        ),
      ),
    );
  }
}

class CardTypeColumn extends StatelessWidget {
  final Pokemon? pokemon;

  const CardTypeColumn({super.key, this.pokemon});

  @override
  Widget build(BuildContext context) {
    if (pokemon != null) {
      return Column(
        children: pokemon!.types
            .map((e) => CardTypeColumnItem(ty: e.type.name))
            .toList(),
      );
    } else {
      return Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 60),
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }
  }
}

class CardImage extends StatelessWidget {
  final int id;

  const CardImage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://raw.githubusercontent.com/PokeAPI/sprites/ca5a7886c10753144e6fae3b69d45a4d42a449b4/sprites/pokemon/$id.png',
      fit: BoxFit.cover,
    );
  }
}

class ListedPokemonCard extends StatelessWidget {
  final PokemonList? pokeList;
  final int page;
  final int item;

  const ListedPokemonCard({
    super.key,
    this.pokeList,
    required this.page,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PokemonScreenApp(id: item + 1)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              if (pokeList != null)
                CardTitle(
                  pokemonName: titleCase(pokeList!.results[item].name),
                )
              else
                const CardTitle(pokemonName: "??????????"),
              const Divider(height: 8),
              FutureBuilder(
                future: PokeApi.getPokemon(1 + page * pageSize + item),
                builder: (context, snapshot) => Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CardTypeColumn(pokemon: snapshot.data),
                      Expanded(
                          child: CardImage(id: 1 + page * pageSize + item)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Greeting extends StatefulWidget {
  const Greeting({super.key});

  @override
  State<Greeting> createState() => _GreetingState();
}

const pageSize = 40;

class _GreetingState extends State<Greeting> {
  int _page = 0;

  set page(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PokemonMassa'),
        ),
        body: FutureBuilder(
          future: PokeApi.getPokemonList(_page * pageSize, pageSize),
          builder: (context, snapshot) => CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(15),
                sliver: SliverGrid.count(
                  childAspectRatio: 1.3,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: List.generate(pageSize, (index) {
                    if (snapshot.hasData) {
                      return ListedPokemonCard(
                        pokeList: snapshot.data!,
                        page: _page,
                        item: index,
                      );
                    } else {
                      return ListedPokemonCard(
                        page: _page,
                        item: index,
                      );
                    }
                  }),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          page = max(0, _page - 1);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Text('${_page + 1}'),
                      IconButton(
                        onPressed: () {
                          page = _page + 1;
                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
