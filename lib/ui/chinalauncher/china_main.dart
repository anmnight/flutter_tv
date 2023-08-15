import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/ui/chinalauncher/movie_tabbar.dart';
import '../../business/movies_bloc.dart';
import '../../domain/movie.dart';

class ChinaMainScreen extends StatefulWidget {
  const ChinaMainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChinaMainScreenState();
}

class _ChinaMainScreenState extends State<ChinaMainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<MoviesBloc>(
          create: (_) => MoviesBloc()..add(MoviesEvent.initializing),
          child: Scaffold(
            body: BlocBuilder<MoviesBloc, MoviesState>(
              builder: (context, state) {
                if (state is MoviesLoadedState) {
                  List<Movie> movies = state.movies;
                  return  MovieTabBar(
                    movies: movies,
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
