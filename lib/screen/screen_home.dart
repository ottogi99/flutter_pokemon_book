import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokemon_illustrated_book/model/api_adapter.dart';
import 'package:pokemon_illustrated_book/screen/screen_pokemon.dart';
import 'package:http/http.dart' as http;

import '../model/model_pokemon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Pokemon> pokemons = <Pokemon>[];
  bool isLoading = false;
  Uri url = Uri.parse('https://django-pokemon-api.herokuapp.com/illustrated_guide/');

  _fetchPokemon() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        pokemons = parsePokemon(utf8.decode(response.bodyBytes));
        for (Pokemon pokemon in pokemons) {
          print(pokemon.name);
          print(pokemon.monType);
          print(pokemon.monTypeList);
        }
        isLoading = false;
      });
    } else {
      throw Exception('failed to load data');
    }
  }
  // List<Pokemon> pokemons = <Pokemon>[
  //   Pokemon.fromMap({
  //     'number': 'No.001',
  //     'name': '이상해씨',
  //     'monType': '풀/독',
  //     'thumbnail':
  //         'https://data1.pokemonkorea.co.kr/newdata/pokedex/mid/000101.png',
  //   }),
  //   Pokemon.fromMap({
  //     'number': 'No.002',
  //     'name': '이상해풀',
  //     'monType': '풀/독',
  //     'thumbnail':
  //         'https://data1.pokemonkorea.co.kr/newdata/pokedex/mid/000201.png',
  //   }),
  //   Pokemon.fromMap({
  //     'number': 'No.003',
  //     'name': '이상해꽃',
  //     'monType': '풀/독',
  //     'thumbnail':
  //         'https://data1.pokemonkorea.co.kr/newdata/pokedex/mid/000301.png',
  //   }),
  // ];

  @override
  void initState() {
    super.initState();
    _fetchPokemon();
  }

  @override
  Widget build(BuildContext context) {
    // 화면 사이즈 구하기
    Size screenSize = MediaQuery.of(context).size;
    // 화면 너비, 높이 구하기
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('포켓몬 도감'),
          backgroundColor: Colors.blueGrey,
          leading: Container(),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? _buildGrid(2)
                : _buildGrid(4);
          },
        ),
      ),
    );
  }

  Widget _buildType(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: width * 0.4,
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Text(
            "풀",
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.04,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: width * 0.4,
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Text(
            "독",
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.04,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildGrid(int columns) {

    return GridView.count(
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      crossAxisCount: columns,
      children: List.generate(pokemons.length, (index) => _buildImage(pokemons[index])),
      // [
      //   _buildImage('images/000101.png'),
      //   _buildImage('images/000201.png'),
      //   _buildImage('images/000301.png'),
      //   _buildImage('images/000302.png'),
      //   _buildImage('images/000303.png'),
      //   _buildImage('images/000401.png'),
      //   _buildImage('images/000501.png'),
      //   _buildImage('images/000601.png'),
      //   _buildImage('images/000602.png'),
      //   _buildImage('images/000603.png'),
      // ],
    );
  }

  // Widget _buildImage(Pokemon pokemon) {
  Widget _buildImage(Pokemon pokemon) {
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonScreen(pokemon: pokemon)))
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PokemonScreen(pokemon: pokemon)));
      },
      child: Container(
        // margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          // color: Colors.amberAccent,
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        // child: Image.asset(pokemon.thumbnail!, fit: BoxFit.cover,),
        child: Image.network(
          pokemon.thumbnail!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
