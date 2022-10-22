package me.fonkamloic.notification_plugin

import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import androidx.annotation.NonNull
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat.getSystemService

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** NotificationPlugin */
class NotificationPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var applicationContext: Context

  companion object {
    const val NOTIFICATION_CHANNEL_ID = "NOTIFICATIONS"
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "notification_plugin")
    channel.setMethodCallHandler(this)
    applicationContext = flutterPluginBinding.applicationContext
    createNotificationChannel()
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
  if (call.method == "showNotification") {
      showNotification(
              call.argument<Int>("id"),
              call.argument<String>("title"),
              call.argument<String>("description")
              )
    result.success(true)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private  fun createNotificationChannel(){
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
      var notificationChannel = NotificationChannel(NOTIFICATION_CHANNEL_ID,
          "Notifications", NotificationManager.IMPORTANCE_DEFAULT
              )
      getSystemService(applicationContext, NotificationManager::class.java)
              ?.createNotificationChannel(notificationChannel)

    }
  }
  private fun showNotification(id: Int?, title: String?, description:String?){
        val builder = NotificationCompat.Builder(applicationContext, NOTIFICATION_CHANNEL_ID)
                .setSmallIcon(applicationContext.resources?.getIdentifier("notification_icon", "drawable", applicationContext.packageName, )!!)
                .setContentTitle(title)
                .setContentText(description)
                .setPriority(NotificationCompat.PRIORITY_DEFAULT)

    NotificationManagerCompat.from(applicationContext)
            .notify(id?:0, builder.build())
  }
}
