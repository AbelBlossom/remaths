import 'package:example/pages/apple_bedtime.dart';
import 'package:example/pages/measure_test.dart';
import 'package:example/pages/node.dart';
import 'package:example/pages/spring.dart';
import 'package:example/pages/timing.dart';
import 'package:example/pages/v2/measure.dart';
import 'package:example/pages/v2/trial.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'remaths example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        "/spring": (_) => const SpringAnimation(),
        "/timing": (_) => const TimingAnimation(),
        "/node": (_) => const NodeTesting(),
        "/apple_bedtime": (_) => const AppleBedtime(),
        "/test": (_) => const VersionTwoTrial(),
        "/measure": (_) => const V2MeasureTest(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var screens = [
      ["Carousel", "/carousel"],
      ["Spring Animation", "/spring"],
      ["Timing Animation", "/timing"],
      ['New Node API', '/node'],
      ["Apple Bedtime", '/apple_bedtime'],
      ["Version 2 Test", "/test"],
      ["Measure", "/measure"]
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Remaths Example"),
      ),
      body: ListView.builder(
        itemCount: screens.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(screens[index][1]);
            },
            title: Text(screens[index][0]),
          );
        },
      ),
    );
  }
}
