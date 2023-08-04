import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/ui/widgets/movie_details.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

import '../../business/movies_bloc.dart';
import 'movie_grid.dart';


class GridMainScreen extends StatefulWidget {
  const GridMainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GridMainScreenState();
}

class _GridMainScreenState extends State<GridMainScreen> {
  Widget _buildTitle() {
    return const Center(
      child: Text(
        'GridLauncher',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMoviesGrid() {
    return Expanded(
      child: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
        if (state is MoviesLoadedState) {
          return MovieGrid(
            movies: state.movies,
            onTapMovie: (movie) => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return MovieDetails(movie: movie);
            })),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final moviesScreen = Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _buildTitle(),
        _buildMoviesGrid(),
      ],
    );

    return BlocProvider<MoviesBloc>(
      create: (_) => MoviesBloc()..add(MoviesEvent.initializing),
      child: Scaffold(
        body: MyPlatform.isTv ? moviesScreen : SafeArea(child: moviesScreen),
      ),
    );
  }
}