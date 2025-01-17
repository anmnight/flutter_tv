import 'package:flutter/material.dart';
import 'package:flutter_tv/framework/remote_controller.dart';
import 'package:flutter_tv/extensions.dart';
import 'package:flutter_tv/framework/platform.dart';
import 'package:flutter_tv/ui/launcher_model_navigator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (MyPlatform.isTVOS || MyPlatform.isWindow) {
    RemoteController().init();
  }
  runApp(const MyApp());
  // SchedulerBinding.instance.addTimingsCallback(FrameReporter().onReportTimings);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    printDebug(MyPlatform.isAndroidTV);
    printDebug(kTvSize.width);
    printDebug(width);
    printDebug(pixelRatio);
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: kTvSize.width,
          height: kTvSize.height,
          child: const LauncherModelNavigator(),
        ),
      ),
    );
  }
}
