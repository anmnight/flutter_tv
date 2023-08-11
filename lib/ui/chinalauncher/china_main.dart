import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/ui/widgets/movie_details.dart';
import 'package:flutter_tv/framework/platform.dart';

import '../../business/movies_bloc.dart';
import 'movie_grid.dart';


class ChinaMainScreen extends StatefulWidget {
  const ChinaMainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChinaMainScreenState();
}

class _ChinaMainScreenState extends State<ChinaMainScreen> {
  Widget _buildTitle() {
    return const Center(
      child: Text(
        'ChinaLauncher',
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
