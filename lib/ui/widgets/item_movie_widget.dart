import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/detail_page.dart';
import 'package:movie_app/ui/general/colors.dart';
import 'package:movie_app/ui/widgets/line_widget.dart';

class ItemMovieWidget extends StatelessWidget {
  MovieModel movieModel;
  ItemMovieWidget({
    required this.movieModel,
  });
  @override
  Widget build(BuildContext context) {
    double Alto = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              peliculaId: movieModel.id,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 16),
        height: Alto * 0.62,
        decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              fit: BoxFit
                  .cover, // esto ajusta todo el fondo con la img del container
              image: NetworkImage(
                  "https://image.tmdb.org/t/p/w500${movieModel.posterPath}"),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ]),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: kBrandPrimaryColor.withOpacity(0.86),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movieModel.originalTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    LineWidget(
                      ancho: 100,
                    ), //linea separadora
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      movieModel.overview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              movieModel.releaseDate
                                  .toString()
                                  .substring(0, 10),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.thumb_up,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              movieModel.voteCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff23232D).withOpacity(0.86),
                ),
                child: Text(
                  movieModel.voteAverage.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
