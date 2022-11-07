import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class Device {
  const Device._();

  static bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  static bool get isDesktop =>
      !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS);

  static WebBrowserInfo? _webBrowserInfo;
  static AndroidDeviceInfo? _androidInfo;
  static IosDeviceInfo? _iosInfo;
  static LinuxDeviceInfo? _linuxInfo;
  static WindowsDeviceInfo? _windowsInfo;
  static MacOsDeviceInfo? _macOsInfo;

  static Future<void> ensureInitialized() async {
    final deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      _webBrowserInfo = await deviceInfo.webBrowserInfo;
    } else if (Platform.isAndroid) {
      _androidInfo = await deviceInfo.androidInfo;
    } else if (Platform.isWindows) {
      _windowsInfo = await deviceInfo.windowsInfo;
    } else if (Platform.isLinux) {
      _linuxInfo = await deviceInfo.linuxInfo;
    } else if (Platform.isMacOS) {
      _macOsInfo = await deviceInfo.macOsInfo;
    } else if (Platform.isIOS) {
      _iosInfo = await deviceInfo.iosInfo;
    }
  }

  static WebBrowserInfo get webBrowserInfo {
    assert(_webBrowserInfo != null, '_webBrowserInfo is null');
    return _webBrowserInfo!;
  }

  static AndroidDeviceInfo get androidInfo {
    assert(_androidInfo != null, '_androidInfo is null');
    return _androidInfo!;
  }

  static IosDeviceInfo get iosInfo {
    assert(_iosInfo != null, '_iosInfo is null');
    return _iosInfo!;
  }

  static LinuxDeviceInfo get linuxInfo {
    assert(_linuxInfo != null, '_linuxInfo is null');
    return _linuxInfo!;
  }

  static WindowsDeviceInfo get windowsInfo {
    assert(_windowsInfo != null, '_windowsInfo is null');
    return _windowsInfo!;
  }

  static MacOsDeviceInfo get macOsInfo {
    assert(_macOsInfo != null, '_macOsInfo is null');
    return _macOsInfo!;
  }
}
