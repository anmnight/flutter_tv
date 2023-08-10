import 'package:flutter/material.dart';
import 'package:flutter_tv/framework/remote_controller.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';
import 'package:flutter_tv/ui/googlelauncher/google_main.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

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
    print(MyPlatform.isAndroidTV);
    print(kTvSize.width);
    print(width);
    print(pixelRatio);
    return MaterialApp(
      home: SizedBox(
        width: kTvSize.width,
        height: kTvSize.height,
        child: const GoogleMainScreen(),
        // child: const GridMainScreen(),
        // child: const ChinaMainScreen(),
      ),
    );
  }
}
