import 'package:flutter/cupertino.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';
import 'package:flutter_tv/ui/googlelauncher/consumer.dart';
import 'package:flutter_tv/ui/googlelauncher/google_main_movie_model.dart';

class GoogleMainBackground extends StatefulWidget {
  GoogleMainBackground({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GoogleMainBackgroundState();
  }
}

class _GoogleMainBackgroundState extends State<GoogleMainBackground> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GoogleMainMovieModel>(
        builder: (context, movie) => Image(
              fit: BoxFit.cover,
              width: context.screenSize.width,
              height: context.screenSize.height,
              image: AssetImage(
                  'assets/images/${movie?.currentFocusMovie.image}.png'),
            ));
  }
}
