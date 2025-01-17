import 'package:flutter/material.dart';
import 'package:flutter_tv/arch/change_notifier_provider.dart';
import 'package:flutter_tv/ui/googlelauncher/google_main_background.dart';
import 'package:flutter_tv/ui/googlelauncher/google_main_movie_model.dart';
import '../../domain/movie.dart';
import 'google_main_list_layout.dart';

class GoogleMainScreen extends StatefulWidget {
  const GoogleMainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GoogleMainState();
  }
}

class _GoogleMainState extends State<GoogleMainScreen> {
  Movie cacheMovie = const Movie(
      name: "", image: "breakingbad", synopsis: "", meta: "", rating: "");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ChangeNotifierProvider<GoogleMainMovieModel>(
          data: GoogleMainMovieModel(),
          child: LayoutBuilder(
            builder: (context, constraints) => SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: const <Widget>[
                  GoogleMainBackground(),
                  GoogleMainListLayout(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
