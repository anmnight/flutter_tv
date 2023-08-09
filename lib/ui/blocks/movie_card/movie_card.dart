import 'package:flutter/cupertino.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

import '../../base/base_movie_card.dart';
import '../../base/tv_focus_card.dart';

typedef MyBuilder = Widget Function({
  required Movie movie,
  required int index,
  required GestureTapCallback onTap,
});

MyBuilder getMovieCard() => MyPlatform.isTv ? getTvCard : getMobileCard;

Widget getTvCard({
  required Movie movie,
  required int index,
  required GestureTapCallback onTap,
}) =>
    TvFocusCard(
      childNode: BaseMovieCard(
        movie: movie,
        index: index,
        onTap: onTap,
      ), blockOnFocus: (bool value) {  }, focusOffsetChange: (Offset value) {  },
    );

Widget getMobileCard({
  required Movie movie,
  required int index,
  required GestureTapCallback onTap,
}) =>
    BaseMovieCard(
      movie: movie,
      index: index,
      onTap: onTap,
      key: ValueKey(movie.name),
    );
