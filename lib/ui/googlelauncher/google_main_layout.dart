import 'package:flutter/material.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

import '../blocks/movie_card/movie_card.dart';

typedef MovieTapHandler = void Function(Movie);

class GoogleMainLayout extends StatelessWidget {
  GoogleMainLayout({
    required this.movies,
    required this.onTapMovie,
    Key? key,
  }) : super(key: key);

  final controller = ScrollController();
  final List<Movie> movies;
  final MovieTapHandler onTapMovie;



  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      itemCount: movies.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: 240,
          padding: EdgeInsets.all(15),
          child: getMovieCard()(
            movie: movies[index],
            index: index,
            onTap: () => onTapMovie(movies[index]),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return VerticalDivider(
          width: 10,
        );
      },
    );
  }
}
