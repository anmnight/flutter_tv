import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/extensions.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';
import 'package:flutter_tv/ui/widgets/movie_details.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

import '../../business/movies_bloc.dart';
import '../../domain/movie.dart';
import 'google_main_layout.dart';

class GoogleMainScreen extends StatefulWidget {
  const GoogleMainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GoogleMainScreenState();
}

class _GoogleMainScreenState extends State<GoogleMainScreen> {
  Movie cacheMovie = Movie(name: "", image: "breakingbad", synopsis: "", meta: "", rating: "");

  Widget _buildBackground() {
    return Image(
      fit: BoxFit.cover,
      width: context.screenSize.width,
      height: context.screenSize.height,
      image: AssetImage('assets/images/${cacheMovie.image}.png'),
    );
  }

  Widget _buildMoviesList() {
    return Container(
      height: 180,
      child: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
        if (state is MoviesLoadedState) {
          cacheMovie = state.movies[0];

          return GoogleMainLayout(
            movies: state.movies,
            movieFocusFunc: (movie) {
              _callback(movie);
            },
            onTapMovie: (movie) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return MovieDetails(movie: movie);
                },
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  void _callback(Movie movie) {
    setState(() {
      cacheMovie = movie;
    });
  }

  @override
  Widget build(BuildContext context) {
    final moviesScreen = Stack(
      alignment: Alignment.bottomCenter,
      children: [_buildBackground(), _buildMoviesList()],
    );

    return BlocProvider<MoviesBloc>(
      create: (_) => MoviesBloc()..add(MoviesEvent.initializing),
      child: Scaffold(
        body: MyPlatform.isTv ? moviesScreen : SafeArea(child: moviesScreen),
      ),
    );
  }
}
