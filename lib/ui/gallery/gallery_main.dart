import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/ui/base/tv_movie_card.dart';
import 'package:flutter_tv/ui/widgets/icon_text_button.dart';
import 'package:flutter_tv/ui/widgets/movie_details.dart';
import 'package:media_kit/media_kit.dart';
import '../../business/movies_bloc.dart';
import '../base/tv_focusable_wrap.dart';
import '../video/single_player_single_video.dart';
import 'big_image_show.dart';
import 'movie_grid.dart';

class GalleryMainScreen extends StatefulWidget {
  const GalleryMainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GalleryMainScreenState();
}

class _GalleryMainScreenState extends State<GalleryMainScreen> {
  BlocProvider<MoviesBloc> _buildMovieBloc() {
    return BlocProvider<MoviesBloc>(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TvFocusableWrap(
            child: const IconTextButton(
              label: "Grid 画廊",
              icon: Icon(Icons.favorite),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return _buildMovieBloc();
                },
              ),
            ),
          ),
          TvFocusableWrap(
            child: const IconTextButton(
              label: "全屏大图",
              icon: Icon(Icons.favorite),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const BigImageShow();
                },
              ),
            ),
          ),
          TvFocusableWrap(
            child: const IconTextButton(
              label: "视频播放",
              icon: Icon(Icons.favorite),
            ),
            onTap: () {
              MediaKit.ensureInitialized();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const SinglePlayerSingleVideoScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
