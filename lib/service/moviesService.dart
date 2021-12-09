import 'dart:convert';

import 'package:star_wars_api/model/movie.model.dart';
import 'package:http/http.dart' as http;

class MovieService {
  final base_url = "https://swapi.dev/api/";

  MovieService() {}

  Future<List<Movie>> getMovies() async {
    try {
      final response = await http.get(Uri.parse('${this.base_url}/films'));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        var _filmsSet = data['results'] as List;

        List<Movie> films = _filmsSet.map((e) => Movie.fromJson(e)).toList();

        // show films url
        films.forEach((element) {
          print(element.url);
        });
        return films;
      } else {
        return [];
      }
    } catch (e) {
      print("erreur consomation ws Article : $e");
      return [];
    }
  }
}
