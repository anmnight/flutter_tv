import 'package:flutter/widgets.dart';

import '../../domain/movie.dart';

class GoogleMainMovieModel extends ChangeNotifier {
  Movie _movie =
      const Movie(name: "", image: "breakingbad", synopsis: "", meta: "", rating: "");

  Movie get currentFocusMovie {
    return _movie;
  }

  void update(Movie movie) {
    _movie = movie;
    notifyListeners();
  }
}
