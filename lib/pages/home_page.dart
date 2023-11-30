import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_service.dart';
import 'package:movie_app/ui/general/colors.dart';
import 'package:movie_app/ui/widgets/item_movie_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MovieModel> peliculas = [];

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() {
    APIService _apiservice = APIService();
    _apiservice.getPeliculas().then((value) {
      //el then es para recibir el future tbm funcionaria el await
      peliculas = value;
      setState(() {});
    });
  }
  // getPeliculas() async {
  //   String _url =
  //       "https://api.themoviedb.org/3/discover/movie?api_key=98b815e22f8410f2b9530452dc8280cd&language=en-US&page=2";
  //   Uri _uri = Uri.parse(_url);
  //   http.Response _response = await http.get(_uri);
  //   if (_response.statusCode == 200) {
  //     Map<String, dynamic> peliculaMap = json.decode(_response.body);
  //     peliculas = peliculaMap["results"]
  //         .map<MovieModel>((e) => MovieModel.fromJson(e))
  //         .toList();

  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Welcome Omar",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Discover ",
                            style: TextStyle(
                              height: 1.25,
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.white12,
                      radius: 26,
                      backgroundImage: NetworkImage(
                        "https://images.pexels.com/photos/39819/woman-girl-eye-models-39819.jpeg?auto=compress&cs=tinysrgb&w=600",
                      ),
                    )
                  ],
                ),
                // seccion categorias

                //
                //seccion listado de peliculas
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: peliculas.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemMovieWidget(
                      movieModel: peliculas[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
