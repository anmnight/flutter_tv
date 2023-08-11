import 'package:flutter/material.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/framework/platform.dart';

import '../base/base_movie_card.dart';
import '../base/tv_focus_card.dart';

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
              crossAxisCount:5,
              childAspectRatio: 1.6,
              crossAxisSpacing: MyPlatform.isTv ? 50 : 10,
              mainAxisSpacing: MyPlatform.isTv ? 50 : 10,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => TvFocusCard(
                childNode: BaseMovieCard(
                  movie: movies[index],
                  index: index,
                  onTap: () => onTapMovie(movies[index]),
                ),
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
