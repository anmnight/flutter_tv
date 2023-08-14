import 'package:flutter/cupertino.dart';
import 'package:flutter_tv/arch/consumer.dart';
import 'package:flutter_tv/ui/googlelauncher/google_main_movie_model.dart';

class GoogleMainBackground extends StatefulWidget {
  const GoogleMainBackground({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GoogleMainBackgroundState();
  }
}

class _GoogleMainBackgroundState extends State<GoogleMainBackground> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GoogleMainMovieModel>(
      builder: (context, movie) => LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Hero(
            tag: movie.toString(),
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/${movie?.currentFocusMovie.image}.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
