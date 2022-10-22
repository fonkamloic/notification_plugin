import 'notification_plugin_platform_interface.dart';

class NotificationPlugin {
  Future<String?> getPlatformVersion() {
    return NotificationPluginPlatform.instance.getPlatformVersion();
  }

  Future<bool> showNotification(int id, String title, String description) {
    return NotificationPluginPlatform.instance
        .showNotification(id, title, description);
  }
}
