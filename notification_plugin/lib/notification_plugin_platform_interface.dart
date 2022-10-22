import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'notification_plugin_method_channel.dart';

abstract class NotificationPluginPlatform extends PlatformInterface {
  /// Constructs a NotificationPluginPlatform.
  NotificationPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static NotificationPluginPlatform _instance =
      MethodChannelNotificationPlugin();

  /// The default instance of [NotificationPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelNotificationPlugin].
  static NotificationPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NotificationPluginPlatform] when
  /// they register themselves.
  static set instance(NotificationPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> showNotification(int id, String title, String description) {
    throw UnimplementedError('showNotification() has not been implemented.');
  }
}
