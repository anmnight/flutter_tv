import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business/movies_bloc.dart';
import 'movie_details.dart';
import 'movie_grid.dart';

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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar Sample'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.cloud_outlined),
            ),
            Tab(
              icon: Icon(Icons.beach_access_sharp),
            ),
            Tab(
              icon: Icon(Icons.brightness_5_sharp),
            ),
          ],
        ),
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
