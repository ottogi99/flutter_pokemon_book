import 'package:flutter/material.dart';

import '../model/model_pokemon.dart';

class PokemonScreen extends StatefulWidget {
  Pokemon pokemon;

  // PokemonScreen({Key? key, required this.pokemon}) : super(key: key);
  PokemonScreen({Key? key, required this.pokemon}) : super(key: key);

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  int _currentIndex = 0;

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
            // leading: Container(),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.network(widget.pokemon.thumbnail!,
                    width: width * 0.8),
              ),
              Padding(padding: EdgeInsets.all(width * 0.024)),
              Text(
                widget.pokemon.number!,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: width * 0.05,
                ),
              ),
              Text(
                widget.pokemon.name!,
                style: TextStyle(
                  fontSize: width * 0.065,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: EdgeInsets.all(width * 0.024)),
              _buildType(width, widget.pokemon),
            ],
          )),
    );
  }

  Widget _buildType(double width, Pokemon pokemon) {
    final boxColors = {
      '노말': Colors.grey,
      '불꽃': Colors.amber,
      '물': Colors.lightBlueAccent,
      '풀': Colors.green,
      '전기': Colors.yellow,
      '얼음': Colors.tealAccent,
      '격투': Colors.red,
      '독': Colors.deepPurple,
      '땅': Colors.brown,
      '비행': Colors.blueGrey,
      '에스퍼': Colors.pinkAccent,
      '벌레': Colors.lightGreen,
      '바위': Colors.amberAccent,
      '고스트': Colors.blueAccent,
      '드래곤': Colors.blueAccent,
      '악': Colors.blueGrey,
      '강철': Colors.cyan,
      '페어리': Colors.purpleAccent,
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(pokemon.monTypeList!.length, (index) {
        return Container(
          width: width * 0.4,
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          decoration: BoxDecoration(
            color: boxColors[pokemon.monTypeList![index]],
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Text(
            pokemon.monTypeList![index],
            style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.04,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }),
    );
  }
}
