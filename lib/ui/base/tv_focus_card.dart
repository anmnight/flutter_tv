import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tv/extensions.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';

class TvFocusCard extends StatefulWidget {
  const TvFocusCard({
    required this.childNode,
    this.onTap,
    required this.blockOnFocus,
    required this.focusOffsetChange,
    Key? key,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final Widget childNode;
  final ValueChanged<bool> blockOnFocus;
  final ValueChanged<Offset> focusOffsetChange;

  @override
  _TvFocusCardState createState() => _TvFocusCardState();
}

class _TvFocusCardState extends State<TvFocusCard> {
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
          borderRadius: BorderRadius.circular(25),
          color: Colors.black12,
          shape: BoxShape.rectangle,
          elevation: _isFocused ? 25 : 10,
          shadowColor: Colors.black,
          duration: _hoverDuration,
          curve: Curves.fastOutSlowIn,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: _isFocused
                  ? Border.all(
                      color: Colors.red,
                      width: 3,
                    )
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(3.0),
              child: widget.childNode,
            ),
          ),
        ),
      ),
    );
  }

// Future<void> _incrementCounter() async {
//   final CustomSharedPreferencesIOS prefs =
//       await CustomSharedPreferencesIOS.getInstance();
//   final int counter = (prefs.getInt('counter') ?? 0) + 1;
//   print('ALDE $counter');
//   prefs.setInt('counter', counter);
// }
}
