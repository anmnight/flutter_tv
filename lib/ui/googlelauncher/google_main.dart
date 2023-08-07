import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';
import 'package:flutter_tv/ui/widgets/movie_details.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

import '../../business/movies_bloc.dart';
import 'google_main_layout.dart';

class GoogleMainScreen extends StatefulWidget {
  const GoogleMainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GoogleMainScreenState();
}

class _GoogleMainScreenState extends State<GoogleMainScreen> {

  Widget _buildBackground() {
    return Image(
      fit: BoxFit.cover,
      width: context.screenSize.width,
      height: context.screenSize.height,
      image: AssetImage('assets/images/bladerunner.png'),
    );
  }

  Widget _buildMoviesList() {
    return Container(
      height: 180,
      margin: EdgeInsets.all(20),
      child: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
        if (state is MoviesLoadedState) {
          return GoogleMainLayout(
            movies: state.movies,
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
