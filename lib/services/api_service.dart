import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/utils/constants.dart';

class APIService {
  Future<List<MovieModel>> getPeliculas() async {
    List<MovieModel> movies = [];
    String _url =
        "$pathProduction/discover/movie?api_key=$apiKey&language=en-US&page=2";
    Uri _uri = Uri.parse(_url);
    http.Response _response = await http.get(_uri);
    if (_response.statusCode == 200) {
      Map<String, dynamic> peliculaMap = json.decode(_response.body);
      movies = peliculaMap["results"]
          .map<MovieModel>((e) => MovieModel.fromJson(e))
          .toList();
      return movies;
    } else {
      return movies;
    }
  }

  Future<MovieDetailModel?> getPelicula(int peliculaId) async {
    //? es para decir que puede devolver null
    String _url = "$pathProduction/movie/$peliculaId?api_key=$apiKey";
    Uri _uri = Uri.parse(_url);
    http.Response response = await http.get(_uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> movieMap = json.decode(response.body);
      MovieDetailModel movieDetailModel = MovieDetailModel.fromJson(movieMap);
      return movieDetailModel;
    }

    return null;
  }
}
