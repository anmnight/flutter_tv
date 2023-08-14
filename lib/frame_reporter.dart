import 'dart:collection';
import 'dart:ui';

import 'package:flutter_tv/extensions.dart';

class FrameReporter {

  static const maxframes = 100; // 100 帧足够了，对于 60 fps 来说
  final lastFrames = ListQueue<FrameTiming>(maxframes);
  static const REFRESH_RATE = 60;
  static const frameInterval = Duration(
      microseconds: Duration.microsecondsPerSecond ~/ REFRESH_RATE);


  void onReportTimings(List<FrameTiming> timings) {
    // 把 Queue 当作堆栈用
    for (FrameTiming timing in timings) {
      lastFrames.addFirst(timing);
    }

    // 只保留 maxframes
    while (lastFrames.length > maxframes) {
      lastFrames.removeLast();
    }

    printDebug("current fps: $fps");
  }


  double get fps {
    var lastFramesSet = <FrameTiming>[];
    for (FrameTiming timing in lastFrames) {
      if (lastFramesSet.isEmpty) {
        lastFramesSet.add(timing);
      } else {
        var lastStart = lastFramesSet.last.timestampInMicroseconds(FramePhase.buildStart);

        if (lastStart - timing.timestampInMicroseconds(FramePhase.rasterFinish) > (frameInterval.inMicroseconds * 2)) {
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
}
