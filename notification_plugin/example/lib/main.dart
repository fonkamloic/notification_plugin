import 'package:flutter/material.dart';
import 'package:notification_plugin/notification_plugin.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int id = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text('Show Notification'),
            onPressed: () async {
              final result = await NotificationPlugin().showNotification(id++,
                  'Flutter!!!', 'Hey there! Notification from flutter app.');

              print(result);
            },
          ),
        ),
      ),
    );
  }
}
