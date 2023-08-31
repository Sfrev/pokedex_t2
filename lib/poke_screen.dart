import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_t2/poke_api.dart';
import 'package:pokedex_t2/sfrevao.dart';

class PokemonScreenApp extends StatelessWidget{
  final int id;

  const PokemonScreenApp({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Screen'),
      ),
        body: FutureBuilder(
          future: PokeApi.getPokemon(id),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              log(snapshot.data.toString() + "IN");
              return LoadedData(poke: snapshot.data);
            }
            else{
              return LoadedData(poke: null);
            }
          }
        ));
  }
}

var typeLen = 3;
class LoadedData extends StatelessWidget{
  final Pokemon? poke;

  const LoadedData({super.key, required this.poke});
  List listUpd(){
      var myList= [];
      const labels = ["Poke IDX:", "Base Experience", "Height", "Weight", "Initial Pokemon?", "Types"];
      var values = [poke!.id.toString(), poke!.baseExperience.toString(), poke!.height.toString(), poke!.weight.toString(), poke!.isDefault ? "True" : "False"];
      for(var i = 0;  i < labels.length; i++){
          if(i != labels.length - 1){
            myList.add('${labels[i]}  ${values[i]}');
            continue;
          }
          var types = poke!.types;
          for(var j = 0; j < types.length; j++){
            myList.add('Type ${j+1}  ${types[j]}');
          }
      }
      typeLen = myList.length;
      return myList;
  }
  @override
  Widget build(BuildContext context){
    List types;
    if(poke != null) {
      types = listUpd();
    } else {
      types = ['------', '------', '------'];
    }
    log('Merda'+types.toString());

    return Column(
      children:[
        const SizedBox(height: 5),

      Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: IconButton.filled(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
        ],
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text((poke != null ? poke!.name :'Nome Legal'),
              style: const TextStyle(fontFamily: 'pokemons', color: Colors.yellow, fontSize: 50),
           )
        ],
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Expanded(
          child:
            Padding(
            padding: const EdgeInsets.all(10),
            child:
            // Image.asset('assets/img.jpg')
            //   CardImage(id: poke!.id),
              LoadedImage(id: poke != null ? poke!.id : null)
            )
          )
        ],
      ),

      // CustomScrollView(
      //   slivers: [
      //     SliverPadding(
      //       padding: const EdgeInsets.all(5),
      //       sliver: SliverGrid.count(
      //         childAspectRatio: 1,
      //         crossAxisCount: 1,
      //         crossAxisSpacing: 5,
      //         mainAxisSpacing: 5,
      //         children: List.generate(typeLen, (index) {
      //             return TypeCard(
      //               txt: types[index],
      //             );
      //         }),
      //       ),
      //     ),
      //   ],
      //   ),
      ],
    );
  }

}

class LoadedImage extends StatelessWidget{
  final int? id;

  const LoadedImage({super.key, required this.id});

  @override
  Widget build(BuildContext context){
    if(id != null) {
      return CardImage(id: id!);
    }

    return Image.asset('assets/img.jpg');

  }

}
class TypeCard extends StatelessWidget{
  final String txt;

  const TypeCard({super.key, required this.txt});

  @override
  Widget build(BuildContext context){

    return Text(txt,
      style: const TextStyle(fontFamily: 'pokemon', color: Colors.black87, fontSize: 20),
    );

  }

}




