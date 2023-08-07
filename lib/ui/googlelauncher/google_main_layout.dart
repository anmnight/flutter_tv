import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/extensions.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

import '../base/base_movie_card.dart';
import '../base/tv_focus_card.dart';
import '../blocks/movie_card/movie_card.dart';

typedef MovieTapHandler = void Function(Movie);

class GoogleMainLayout extends StatelessWidget {
  GoogleMainLayout({
    required this.movies,
    required this.onTapMovie,
    this.movieFocusFunc,
    Key? key,
  }) : super(key: key);

  final _controller = ScrollController();
  final List<Movie> movies;
  final MovieTapHandler onTapMovie;
  final MovieFocusFunc? movieFocusFunc;

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
        focusNode: FocusNode(onKey: (node, keyEvent) {
          // print("keyEvent:${keyEvent.logicalKey}");
          if (keyEvent.logicalKey == LogicalKeyboardKey.arrowRight) {
            //todo 添加平移动画
            //   Future.delayed(Duration.zero, () {
            //     _controller.animateTo(
            //       240 * 10,
            //       duration: Duration(milliseconds: 200),
            //       curve: Curves.ease,
            //     );
            //   });
          }

          return KeyEventResult.ignored;
        }),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          controller: _controller,
          physics: BouncingScrollPhysics(),
          itemCount: movies.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 240,
              padding: EdgeInsets.all(15),
              child: TvFocusCard(
                focusCallback: (onFocus) {
                  if (onFocus && movieFocusFunc != null) {
                    movieFocusFunc!(movies[index]);
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
          separatorBuilder: (BuildContext context, int index) {
            return VerticalDivider(
              width: 10,
            );
          },
        ));
  }
}
