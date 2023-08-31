import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class PokemonListEntry {
  final String name;
  final String url;

  const PokemonListEntry({required this.name, required this.url});

  factory PokemonListEntry.fromJson(Map<String, dynamic> json) {
    return PokemonListEntry(name: json['name'], url: json['url']);
  }
}

class PokemonList {
  final int count;
  final List<PokemonListEntry> results;

  const PokemonList({required this.count, required this.results});

  factory PokemonList.fromJson(Map<String, dynamic> json) {
    return PokemonList(
      count: json['count'],
      results: (json['results'] as List<dynamic>)
          .map((v) => PokemonListEntry.fromJson(v))
          .toList(),
    );
  }
}

class PokemonType {
  final String name;

  const PokemonType({required this.name});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(name: json['name']);
  }
}

class Magalmon {
  final PokemonType type;

  const Magalmon({required this.type});

  factory Magalmon.fromJson(Map<String, dynamic> json) {
    return Magalmon(type: PokemonType.fromJson(json['type']));
  }
}

class Pokemon {
  final int id;
  final String name;
  final int baseExperience;
  final int height;
  final bool isDefault;
  final int weight;
  final List<Magalmon> types;

  const Pokemon({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.isDefault,
    required this.weight,
    required this.types,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      baseExperience: json['base_experience'],
      height: json['height'],
      isDefault: json['is_default'],
      weight: json['weight'],
      types: (json['types'] as List<dynamic>)
          .map((v) => Magalmon.fromJson(v))
          .toList(),
    );
  }
}

class PokeApi {
  static Future<Pokemon> getPokemon(int id) async {
    log('Trying to get $id');
    try{
      final res = await http.get(
        Uri(
          scheme: 'https',
          host: 'pokeapi.co',
          path: '/api/v2/pokemon/$id',
        ),
      );

      log('Poke Api'+res.toString());
      if (res.statusCode == 200) {
        return Pokemon.fromJson(jsonDecode(res.body));
      } else {
        throw Exception();
      }
    }
    catch(e){
      log('AAAAAAA'+e.toString());
      throw Exception();
    }
  }

  static Future<PokemonList> getPokemonList(int offset, int limit) async {
    final res = await http.get(
      Uri(
        scheme: "https",
        host: "pokeapi.co",
        path: "/api/v2/pokemon",
        queryParameters: {
          'offset': offset.toString(),
          'limit': limit.toString(),
        },
      ),
    );


    if (res.statusCode == 200) {
      return PokemonList.fromJson(jsonDecode(res.body));
    } else {
      throw Exception();
    }
  }
}
