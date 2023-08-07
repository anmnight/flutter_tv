import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_tv/frame_reporter.dart';
import 'package:flutter_tv/framework/remote_controller.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';
import 'package:flutter_tv/ui/focus/scale_widget.dart';
import 'package:flutter_tv/select_model_screen.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (MyPlatform.isTVOS || MyPlatform.isWindow) {
    RemoteController().init();
  }
  runApp(const MyApp());
  SchedulerBinding.instance.addTimingsCallback(FrameReporter().onReportTimings);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const screen = SelectModelScreen();
    print(MyPlatform.isAndroidTV);
    print(kTvSize.width);
    print(width);
    print(pixelRatio);
    return MaterialApp(
        home: isScaled
            ? ScaleWidget(
                child: screen,
              )
            : screen);
  }
}
