import 'package:flutter/material.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/extensions.dart';
import 'package:flutter_tv/framework/platform.dart';
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
          padding: const EdgeInsets.all(28),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MyPlatform.isTv
                  ? 5
                  : (context.screenSize.width / 250).round(),
              childAspectRatio: 1.6,
              crossAxisSpacing: MyPlatform.isTv ? 50 : 10,
              mainAxisSpacing: MyPlatform.isTv ? 50 : 10,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => TvMovieCard(
                movie: movies[index],
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
