import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/extensions.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../base/base_movie_card.dart';
import '../base/tv_focus_card.dart';
import '../blocks/movie_card/movie_card.dart';

typedef MovieTapHandler = void Function(Movie);

class GoogleMainListLayout extends StatelessWidget {
  GoogleMainListLayout({
    required this.movies,
    required this.onTapMovie,
    this.movieFocusFunc,
    Key? key,
  }) : super(key: key);

  final _itemScrollController = ItemScrollController();
  final List<Movie> movies;
  final MovieTapHandler onTapMovie;
  final MovieFocusFunc? movieFocusFunc;

  double itemWidth = 240.0;

  void _moveToItem(int item) {
    Future.delayed(Duration.zero, () {
      _itemScrollController.scrollTo(
        index: item,
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: itemWidth,
          padding: EdgeInsets.all(15),
          child: TvFocusCard(
            focusCallback: (onFocus) {
              if (onFocus && movieFocusFunc != null) {
                movieFocusFunc!(movies[index]);
              }
            },
            offsetCallback: (offset) {
              if (offset.dx < 600) {
                if (index <= 1) {
                  _moveToItem(0);
                } else {
                  _moveToItem(index - 1);
                }
              }
            },
            childNode: BaseMovieCard(
              movie: movies[index],
              index: index,
              onTap: () => onTapMovie(movies[index]),
            ),
          ),
        );
      },
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemScrollController: _itemScrollController,
    );
  }
}
