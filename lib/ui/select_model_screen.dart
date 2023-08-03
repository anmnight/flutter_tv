import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tv/ui/widgets/focus_button.dart';

import 'movies_screen.dart';

class SelectModelScreen extends StatelessWidget {
  const SelectModelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FocusButton(
              label: "Go Grid Launcher",
              icon: Icon(Icons.ac_unit_outlined),
              onTap: () {
                print("Go Google Launcher");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MoviesScreen();
                    },
                  ),
                );
              },
            ),
            FocusButton(
              label: "Go Google Launcher",
              icon: Icon(Icons.ac_unit_outlined),
              onTap: () {
                print("Go Google Launcher");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MoviesScreen();
                    },
                  ),
                );
              },
            ),
            FocusButton(
              label: "Go China Launcher",
              icon: Icon(color: Colors.red, Icons.beach_access_sharp),
              onTap: () {
                print("Go China Launcher");
              },
            ),
          ],
        ),
      ),
    );
  }
}
