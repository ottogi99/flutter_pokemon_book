import 'dart:convert';
import 'model_pokemon.dart';

List<Pokemon> parsePokemon(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Pokemon>((json) => Pokemon.fromJson(json)).toList();
}