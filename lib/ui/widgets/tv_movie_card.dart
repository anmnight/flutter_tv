import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tv/domain/movie.dart';
import 'package:flutter_tv/extensions.dart';

class TvMovieCard extends StatefulWidget {
  const TvMovieCard({
    this.onTap,
    required this.blockOnFocus,
    required this.focusOffsetChange,
    required this.movie,
    Key? key,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final ValueChanged<bool> blockOnFocus;
  final ValueChanged<Offset> focusOffsetChange;
  final Movie movie;

  @override
  State<TvMovieCard> createState() => _TvMovieCardState();
}

class _TvMovieCardState extends State<TvMovieCard> {
  bool _isFocused = false;
  static const _hoverDuration = Duration(milliseconds: 60);

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onFocusChange: (value) => setState(() {
        _isFocused = value;
        widget.blockOnFocus(value);
      }),
      onKey: (_, event) {
        if (event is RawKeyUpEvent) {
          widget.focusOffsetChange(_.offset);
        }

        if (widget.onTap != null && event.hasSubmitIntent) {
          widget.onTap!();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: AnimatedScale(
        scale: _isFocused ? 1.1 : 1.0,
        duration: _hoverDuration,
        child: AnimatedPhysicalModel(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black12,
          shape: BoxShape.rectangle,
          elevation: _isFocused ? 10 : 0,
          shadowColor: Colors.black,
          duration: _hoverDuration,
          curve: Curves.fastOutSlowIn,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/${widget.movie.image}.png'),
              ),
              border: _isFocused
                  ? Border.all(
                      color: Colors.red,
                      width: 3,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
