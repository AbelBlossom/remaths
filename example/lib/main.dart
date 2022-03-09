import 'package:example/pages/carousel.dart';
import 'package:example/pages/measure_test.dart';
import 'package:example/pages/node.dart';
import 'package:example/pages/spring.dart';
import 'package:example/pages/timing.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        "/carousel": (_) => const Carousel(),
        "/spring": (_) => SpringAnimation(),
        "/timing": (_) => TimingAnimation(),
        "/node": (_) => const NodeTesting(),
        "/measure": (_) => const MeasureTest()
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
      ["Measurement", '/measure']
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
