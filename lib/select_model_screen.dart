import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tv/ui/base/tv_focus_card.dart';
import 'package:flutter_tv/ui/blocks/icon_text_button.dart';
import 'package:flutter_tv/ui/chinalauncher/china_main.dart';
import 'package:flutter_tv/ui/googlelauncher/google_main.dart';
import 'package:flutter_tv/ui/gridlauncher/grid_main.dart';

class SelectModelScreen extends StatelessWidget {
  const SelectModelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          spacing: 100,
          children: <Widget>[
            TvFocusCard(
              childNode: IconTextButton(
                label: "Go Grid Launcher",
                icon: Icon(color: Colors.red, Icons.ac_unit_outlined),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return GridMainScreen();
                    },
                  ),
                );
              },
            ),
            TvFocusCard(
              childNode: IconTextButton(
                label: "Go China Launcher",
                icon: Icon(color: Colors.red, Icons.beach_access_sharp),
              ),
              onTap: () {
                print("Go China Launcher");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ChinaMainScreen();
                    },
                  ),
                );
              },
            ),
            TvFocusCard(
              childNode: IconTextButton(
                label: "Go Google Launcher",
                icon: Icon(color: Colors.red, Icons.ac_unit_outlined),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return GoogleMainScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
