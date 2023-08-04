import 'package:flutter/material.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';
import 'package:custom_shared_preferences_ios/custom_shared_preferences_ios.dart';

class TvFocusCard extends StatefulWidget {
  final GestureTapCallback? onTap;
  final Widget childNode;

  const TvFocusCard({
    required this.childNode,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _TvFocusCardState createState() => _TvFocusCardState();
}

class _TvFocusCardState extends State<TvFocusCard> {
  bool _isFocused = false;
  static const _hoverDuration = Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onFocusChange: (value) => setState(() {
        _isFocused = value;
        print("onFocusChange : $value");
      }),
      onKey: (_, event) {
        if (widget.onTap != null && event.hasSubmitIntent) {
          widget.onTap!();
          _incrementCounter();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: AnimatedScale(
        scale: _isFocused ? 1.2 : 1.0,
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

  Future<void> _incrementCounter() async {
    final CustomSharedPreferencesIOS prefs =
        await CustomSharedPreferencesIOS.getInstance();
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('ALDE $counter');
    prefs.setInt('counter', counter);
  }
}
