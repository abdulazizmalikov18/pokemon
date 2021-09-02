import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemonapp/models/pokemon.dart';
import 'package:pokemonapp/ui/pokemonDiteil.dart';

class PokemonList extends StatefulWidget {
  PokemonList({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PokemonList> {
  var dataFromInternetVariable;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataFromInternetVariable = dataFromInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: FutureBuilder(
          future: dataFromInternetVariable,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Platform.isAndroid
                  ? CircularProgressIndicator()
                  : CupertinoActivityIndicator();
            } else {
              return GridView.count(
                crossAxisCount: 2,
                children: snapshot.data.pokemon.map<Widget>(
                  (poke) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return PokemonDetail(
                                kelganPoke: poke,
                                data: snapshot.data,
                              );
                            },
                          ),
                        );
                      },
                      child: Hero(
                        tag: poke.img,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.shade50,
                                offset: Offset(0.5, 0.10),
                                blurRadius: 2,
                              ),
                            ],
                            border: Border.all(color: Colors.black, width: 0.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/loading-icegif-1.gif',
                                    image: poke.img != ''
                                        ? poke.img
                                        : "https://www.google.com/url?sa=i&url=https%3A%2F%2Fdribbble.com%2Fshots%2F4814970-Quick-idea-for-loading-gif&psig=AOvVaw0GgDG-lpU2VpzyfmvRBFVD&ust=1628082773644000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCNix1I_3lPICFQAAAAAdAAAAABA9",
                                  ),
                                ),
                              ),
                              Text(
                                "${poke.name}",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              );
            }
          },
        ),
      ),
    );
  }

  dataFromInternet() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/Biuni/PokemonGo-Pokedex/master/pokedex.json'));
    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
