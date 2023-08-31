import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_t2/dbHelper.dart';
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
              return LoadedData(poke: snapshot.data, pokeId: id,);
            }
            else{
              return LoadedData(poke: null, pokeId: id,);
            }
          }
        ));
  }
}

var typeLen = 3;
class LoadedData extends StatelessWidget{
  final Pokemon? poke;
  final int pokeId;
  const LoadedData({super.key,  required this.pokeId, required this.poke});
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
            myList.add('Type ${j+1}  ${types[j].type.name}');
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
    typeLen = types.length;

    return Column(
      children:[
        const SizedBox(height: 5),

      Row(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child:
                SwitchExample(pokeId: pokeId),
              // IconButton.filled(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   icon: const Icon(Icons.arrow_back),
              // ),
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
      Expanded(child:

        CustomScrollView(
          slivers:
            List.generate(typeLen, (index) {
              log('INDEX $index OF $typeLen');
              return SliverToBoxAdapter(
                child:
                    Center(
                      child:
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child:
                              TypeCard(
                                txt: types[index],
                              ),
                          )
                    )
              );
            }),
          ),
      ),
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
      style: const TextStyle(fontFamily: 'pokemons', color: Colors.black87, fontSize: 20),
    );

  }

}

class SwitchExample extends StatefulWidget {
  final int pokeId;
  const SwitchExample({super.key, required this.pokeId});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {

  bool light = false;

  @override
  Widget build(BuildContext context) {
    final MaterialStateProperty<Color?> trackColor =
    MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        // Track color when the switch is selected.
        if (states.contains(MaterialState.selected)) {
          return Colors.amber;
        }
        // Otherwise return null to set default track color
        // for remaining states such as when the switch is
        // hovered, focused, or disabled.
        return null;
      },
    );
    final MaterialStateProperty<Color?> overlayColor =
    MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        // Material color when switch is selected.
        if (states.contains(MaterialState.selected)) {
          log('LIGANDO');
          // dbHelper.db.insertPoke(MyPokes(id: widget.pokeId));
          // light = true;
          return Colors.amber.withOpacity(0.54);
        }
        // Material color when switch is disabled.
        if (states.contains(MaterialState.disabled)) {
          log('DESLIGANDO');
          // dbHelper.db.deletePoke(MyPokes(id: widget.pokeId));
          // light = false;
          return Colors.grey.shade400;
        }
        // Otherwise return null to set default material color
        // for remaining states such as when the switch is
        // hovered, or focused.
        return null;
      },
    );

    return
      FutureBuilder(
          future: dbHelper.db.getAllPokes(),
          builder: (context, snapshot) {
            if(snapshot.hasData && !light){
              log("Snap data ${snapshot.data.toString()} ${snapshot.data!.length}");
              for(var i = 0; i < snapshot.data!.length; i++){
                log("indice $i = ${snapshot.data![i].id}");
                if(snapshot.data![i].id == widget.pokeId){
                  light = true;
                  break;
                }
              }
            }
            else{
              log('Desiste bd');
              light = false;
            }
            return
              Switch(
                // This bool value toggles the switch.
                value: light,
                overlayColor: overlayColor,
                trackColor: trackColor,
                thumbColor: const MaterialStatePropertyAll<Color>(Colors.black),
                onChanged: (bool value) {
                  // This is called when the user toggles the switch.
                  setState(() {
                    if(!value){
                      dbHelper.db.deletePoke(MyPokes(id: widget.pokeId));
                    }
                    else{
                      dbHelper.db.insertPoke(MyPokes(id: widget.pokeId));
                    }
                    light = value;
                  });
                },
            );
          }
      )
    ;
  }
}





