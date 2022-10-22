import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'notification_plugin_platform_interface.dart';

/// An implementation of [NotificationPluginPlatform] that uses method channels.
class MethodChannelNotificationPlugin extends NotificationPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('notification_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
  @override
  Future<bool> showNotification(
      int id, String title, String description) async {
    final result = await methodChannel.invokeMethod<bool>('showNotification',
        <String, Object>{'id': id, 'title': title, 'description': description});
    return result ?? false;
  }
}
