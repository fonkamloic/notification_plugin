import Flutter
import UIKit

public class SwiftNotificationPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "notification_plugin", binaryMessenger: registrar.messenger())
    let instance = SwiftNotificationPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if(call.method == "showNotification"){
          //Todo: showNotification()
          showNotification(argsMap: call.arguments as! NSDictionary)
          result(true)
      }else{
          result(FlutterMethodNotImplemented)
      }
   
  }
    
    private func showNotification(argsMap: NSDictionary){
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound, .badge],completionHandler: {success, error in
            if (!success) {
                print(error?.localizedDescription ?? "Notifications were not authorized")
            }
            
        })
        
        let content = UNMutableNotificationContent()
        content.title = argsMap.value(forKey: "title") as! String;
        content.body = argsMap.value(forKey: "description") as! String;
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false);
        
        let id = argsMap.value(forKey: "id") as! Int;
        
        let request = UNNotificationRequest(identifier: String(id), content: content, trigger: trigger);
        
        UNUserNotificationCenter.current().add(request);
    }
}


@available(iOS 10.0, *)
extension SwiftNotificationPlugin: UNUserNotificationCenterDelegate{
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
}
