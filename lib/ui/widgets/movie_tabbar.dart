import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/movies_bloc.dart';
import '../chinalauncher/movie_grid.dart';
import 'movie_details.dart';

class MovieTabBar extends StatefulWidget {
  const MovieTabBar({super.key});

  @override
  State<MovieTabBar> createState() => _MovieTabBarState();
}

class _MovieTabBarState extends State<MovieTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      var index = _tabController.index;
      print("index: $index");
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: _tabController,
        tabs: const <Widget>[
          Tab(
            height: 100,
            icon: Icon(Icons.cloud_outlined),
          ),
          Tab(
            height: 100,
            icon: Icon(Icons.beach_access_sharp),
          ),
          Tab(
            height: 100,
            icon: Icon(Icons.brightness_5_sharp),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
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
          BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
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
          BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
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
        ],
      ),
    );
  }
}
