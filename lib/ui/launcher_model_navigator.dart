import 'package:flutter/material.dart';
import 'package:flutter_tv/ui/widgets/tv_focusable_wrap.dart';
import 'chinalauncher/china_main.dart';
import 'gallery/gallery_main.dart';
import 'googlelauncher/google_main.dart';

class LauncherModelNavigator extends StatelessWidget {
  const LauncherModelNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TvFocusableWrap(
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Google Launcher",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const GoogleMainScreen();
              },
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        TvFocusableWrap(
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Gallery Launcher",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const GalleryMainScreen();
              },
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        TvFocusableWrap(
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "China Launcher",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const ChinaMainScreen();
              },
            ),
          ),
        ),
      ],
    );
  }
}
