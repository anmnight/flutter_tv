import 'package:flutter/material.dart';
import 'package:flutter_tv/ui/chinalauncher/widget/china_launcher_tabbar.dart';
import 'package:flutter_tv/ui/widgets/scale_widget.dart';

class ChinaMainScreen extends StatefulWidget {
  const ChinaMainScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChinaMainScreenState();
}

class _ChinaMainScreenState extends State<ChinaMainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScaleWidget(
        child: const ChinaLauncherTabBar(),
      ),
    );
  }
}
