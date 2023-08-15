import 'package:flutter/material.dart';
import 'package:flutter_tv/extensions.dart';

class TvFocusableWrap extends StatefulWidget {
  const TvFocusableWrap({
    required this.child,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final Widget child;

  @override
  State<TvFocusableWrap> createState() => _TvFocusableWrapState();
}

class _TvFocusableWrapState extends State<TvFocusableWrap> {
  bool _isFocused = false;
  static const _hoverDuration = Duration(milliseconds: 60);

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onFocusChange: (value) => setState(() {
        _isFocused = value;
      }),
      onKey: (_, event) {
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
          child: widget.child,
        ),
      ),
    );
  }
}
