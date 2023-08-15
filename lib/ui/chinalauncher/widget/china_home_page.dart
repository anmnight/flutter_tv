import 'package:flutter/material.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/services/dummy_movies_service.dart';

typedef MovieTapHandler = void Function(Movie);

class ChinaHomePage extends StatelessWidget {
  const ChinaHomePage({
    required this.tabId,
    Key? key,
  }) : super(key: key);

  final String tabId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: DummyMoviesService().getMovies(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            List<Movie> movies = snapshot.data;

            return Text("Contents: ${snapshot.data}");
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
