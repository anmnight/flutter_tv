import 'dart:ui';

import 'domain/movie.dart';

bool debug = true;

void printDebug(Object object) {
  if (debug) {
    print(object);
  }
}

typedef MovieFocusFunc = void Function(Movie movie);

typedef FocusCallback = void Function(bool onFocus);

typedef OffsetCallback = void Function(Offset offset);
