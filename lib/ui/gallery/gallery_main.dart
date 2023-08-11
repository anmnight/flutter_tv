import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/extensions.dart';
import 'package:flutter_tv/ui/widgets/movie_details.dart';
import '../../business/movies_bloc.dart';
import 'movie_grid.dart';

class GalleryMainScreen extends StatefulWidget {
  const GalleryMainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GalleryMainScreenState();
}

class _GalleryMainScreenState extends State<GalleryMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<MoviesBloc>(
        create: (_) => MoviesBloc()..add(MoviesEvent.initializing),
        child: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
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
          },
        ),
      ),
    );
  }
}
