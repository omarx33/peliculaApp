import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/services/api_service.dart';
import 'package:movie_app/ui/general/colors.dart';
import 'package:movie_app/ui/widgets/item_cast_widget.dart';
import 'package:movie_app/ui/widgets/line_widget.dart';
import 'package:url_launcher/url_launcher.dart';

//slivers
class DetailPage extends StatefulWidget {
  int peliculaId;

  DetailPage({required this.peliculaId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final APIService _apiService = APIService();
  MovieDetailModel? movieDetailModel; //? = puede ser null
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() {
    //widget.peliculaId viene de int peliculaId; de arriva, widget trae las variables de arriva
    _apiService.getPelicula(widget.peliculaId).then((value) {
      if (value != null) {
        //manda el valor json al modelo y el modelo retorna un mapa
        movieDetailModel = value;
        isLoading = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrandPrimaryColor,
      //si isLoading es falso, operador ternario para el before mientras carga los datos mostrar CircularProgressIndicator
      body: !isLoading
          ? CustomScrollView(
              slivers: [
                //solo acepta slivers
                SliverAppBar(
                  title: Text(
                    movieDetailModel!.originalTitle,
                  ),
                  backgroundColor: kBrandPrimaryColor,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          "https://image.tmdb.org/t/p/w500${movieDetailModel!.backdropPath}",
                          fit: BoxFit.fitWidth,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            //degradado de color en la parte superior
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              kBrandPrimaryColor,
                              kBrandPrimaryColor.withOpacity(0.01),
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                  floating: false,
                  snap: false,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${movieDetailModel!.posterPath}",
                                  height: 160,
                                  width: 120,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.date_range,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          movieDetailModel!.releaseDate
                                              .toString()
                                              .substring(0, 10),
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      movieDetailModel!.originalTitle,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.timelapse,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "${movieDetailModel!.runtime} min. ",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "OverView",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          LineWidget(
                            ancho: 50,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            movieDetailModel!.overview,
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            //boton de redireccionamiento
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                Uri _uri =
                                    Uri.parse(movieDetailModel!.homepage);
                                await launchUrl(_uri);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kBrandSecondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: Icon(
                                Icons.link,
                                color: Colors.white,
                              ),
                              label: Text(
                                "Home page",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Genero",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          LineWidget(
                            ancho: 50,
                          ),
                          Wrap(
                            // en ves de row, salta asia abajo para no desbordar
                            alignment: WrapAlignment.start,
                            spacing: 8.0,
                            // runSpacing: 20,espacios en vertical
                            children: movieDetailModel!.genres
                                .map(
                                  (e) => Chip(
                                    label: Text(
                                      e.name,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          Text(
                            "Cast",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          LineWidget(
                            ancho: 50,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ItemCastWidget(),
                                ItemCastWidget(),
                                ItemCastWidget(),
                                ItemCastWidget(),
                                ItemCastWidget(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                  ]),
                )
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
