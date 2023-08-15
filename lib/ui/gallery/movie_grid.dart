import 'package:flutter/material.dart';
import 'package:flutter_tv/domain/movie.dart';
import '../widgets/tv_movie_card.dart';

typedef MovieTapHandler = void Function(Movie);

class MovieGrid extends StatelessWidget {
  MovieGrid({
    required this.movies,
    required this.onTapMovie,
    Key? key,
  }) : super(key: key);

  final controller = ScrollController();
  final List<Movie> movies;
  final MovieTapHandler onTapMovie;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(18),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1.6,
              crossAxisSpacing: 50,
              mainAxisSpacing: 50,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => TvMovieCard(
                movie: movies[index],
                onTap: () => onTapMovie(movies[index]),
                blockOnFocus: (bool value) {},
                focusOffsetChange: (Offset value) {},
              ),
              childCount: movies.length,
            ),
          ),
        )
      ],
    );
  }
}
