import 'package:flutter/material.dart';
import 'package:iot_dashboard/resources/repo/MQTT.dart';
import 'package:iot_dashboard/screen/app_container.dart';

void main() {
  MQTT.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/home': (context) =>
        const AppContainer(
          title: 'IOT Dashboard',
          routeName: '/home',
        ),
        '/datasensor': (context) =>
        const AppContainer(
          title: 'Data sensor',
          routeName: '/datasensor',
        ),
        '/action': (context) =>
        const AppContainer(
          title: 'Action',
          routeName: '/action',
        ),
        '/about': (context) =>
        const AppContainer(
          title: 'About',
          routeName: '/about',
        ),
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AppContainer(title: 'IOT Dashboard', routeName: '/home'),
    );
  }
}

