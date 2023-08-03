import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tv/business/movies_bloc.dart';
import 'package:flutter_tv/framework/remote_controller.dart';
import 'package:flutter_tv/ui/focus/extensions.dart';
import 'package:flutter_tv/ui/focus/scale_widget.dart';
import 'package:flutter_tv/ui/select_model_screen.dart';
import 'package:flutter_tv/ui/widgets/platform.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (MyPlatform.isTVOS) {
    RemoteController().init();
  }
  runApp(const MyApp());
  SchedulerBinding.instance.addTimingsCallback(_onReportTimings);
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

const maxframes = 100; // 100 帧足够了，对于 60 fps 来说
final lastFrames = ListQueue<FrameTiming>(maxframes);
const REFRESH_RATE = 60;
const frameInterval = const Duration(
    microseconds: Duration.microsecondsPerSecond ~/ REFRESH_RATE);

void _onReportTimings(List<FrameTiming> timings) {
  // 把 Queue 当作堆栈用
  for (FrameTiming timing in timings) {
    lastFrames.addFirst(timing);
  }

  // 只保留 maxframes
  while (lastFrames.length > maxframes) {
    lastFrames.removeLast();
  }

  print("current fps: $fps");
}

double get fps {
  var lastFramesSet = <FrameTiming>[];
  for (FrameTiming timing in lastFrames) {
    if (lastFramesSet.isEmpty) {
      lastFramesSet.add(timing);
    } else {
      var lastStart =
          lastFramesSet.last.timestampInMicroseconds(FramePhase.buildStart);
      if (lastStart - timing.timestampInMicroseconds(FramePhase.rasterFinish) >
          (frameInterval.inMicroseconds * 2)) {
        // in different set
        break;
      }
      lastFramesSet.add(timing);
    }
  }
  var framesCount = lastFramesSet.length;
  var costCount = lastFramesSet.map((t) {
    // 耗时超过 frameInterval 会导致丢帧
    return (t.totalSpan.inMicroseconds ~/ frameInterval.inMicroseconds) + 1;
  }).fold(0, (a, b) => a + b);
  return framesCount * REFRESH_RATE / costCount;
}
