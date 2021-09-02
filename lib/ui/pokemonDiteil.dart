import 'package:flutter/material.dart';
import 'package:pokemonapp/models/pokemon.dart';
import 'dart:math';

class PokemonDetail extends StatelessWidget {
  var kelganPoke;
  Pokemon? pokemon;
  var data;
  PokemonDetail({this.kelganPoke, this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        elevation: 0,
        title: Text(kelganPoke.name.toString()),
      ),
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width - 40,
            height: MediaQuery.of(context).size.height - 250,
            top: 25,
            right: 20,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide.none,
              ),
              elevation: 1,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: kelganPoke.img,
              child: Image.network(
                kelganPoke.img,
                fit: BoxFit.cover,
                width: 170,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "${kelganPoke.candy}",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: chiplar(),
              ),
              kelganPoke.nextEvolution != null
                  ? Padding(
                      padding: EdgeInsets.all(28),
                      child: ListTile(
                        trailing: Icon(Icons.arrow_forward),
                        title: Text("Next Level"),
                        subtitle: Text("${kelganPoke.nextEvolution[0].name}"),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(28),
                      child: Text(
                        "There is no Next Evolution",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Container(
                  height: 100,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      int son = a();
                      return Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(data.pokemon[son].img),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            child: Text("${data.pokemon[son].name}"),
                            bottom: 0,
                          ),
                        ],
                      );
                    },
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> chiplar() {
    List<Widget> list = [];
    for (var i = 0; i < kelganPoke.weaknesses.length; i++) {
      list.add(
        Chip(
          padding: EdgeInsets.all(5),
          backgroundColor: Colors.amberAccent,
          label: Text('${kelganPoke.weaknesses[i]}'),
        ),
      );
    }
    return list;
  }

  a() {
    int son = Random().nextInt(100);
    return son;
  }
}
