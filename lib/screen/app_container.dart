import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iot_dashboard/screen/about_page.dart';
import 'package:iot_dashboard/screen/history_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../resources/model/LiveData.dart';
import '../resources/widgets/AnimatedBox.dart';
import '../resources/widgets/GradientBox.dart';
import 'dart:math' as math;

import '../resources/widgets/SearchView.dart';
import 'action_page.dart';
import 'home_page.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({super.key, required this.title, required this.routeName});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String routeName;
  final String title;

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    _selectedIndex = widget.routeName == '/home'
        ? 0
        : widget.routeName == '/datasensor'
            ? 1
            : widget.routeName == '/action'
                ? 2
                : widget.routeName == '/about'
                    ? 3
                    : 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              title: const Text('Data sensor'),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
                Navigator.pushNamed(context, '/datasensor');
              },
            ),
            ListTile(
              title: const Text('Action'),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
                Navigator.pushNamed(context, '/action');
              },
            ),
            ListTile(
              title: const Text('About me'),
              selected: _selectedIndex == 3,
              onTap: () {
                // Update the state of the app
                _onItemTapped(3);
                // Then close the drawer
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: widget.routeName == '/home'
            ? const MyHomePage()
            : widget.routeName == '/datasensor'
                ? DataSensorPage()
                : widget.routeName == '/action'
                    ? ActionPage()
                    : const AboutPage(),
      ),
    );
  }
}
