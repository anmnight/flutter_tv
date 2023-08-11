import 'dart:io';

class MyPlatform {
  static const tvMode = String.fromEnvironment('TV_MODE');

  // static bool get isTv => tvMode == 'ON';
  static bool get isTv => true;

  // static bool get isIOS => !isTv && Platform.isIOS;

  // static bool get isAndroid => !isTv && Platform.isAndroid;

  static bool get isTVOS => isTv && Platform.isIOS;

  static bool get isWindow => isTv && Platform.isWindows;

  static bool get isLinux => isTv && Platform.isLinux;

  // static bool get isAndroidTV => isTv && Platform.isAndroid;
  static bool get isAndroidTV => true;
}
