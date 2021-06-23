import 'package:example/pages/carousel.dart';
import 'package:example/pages/spring.dart';
import 'package:example/pages/timing.dart';
import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';

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
      home: HomePage(),
      routes: {
        "/carousel": (_) => Carousel(),
        "/spring": (_) => SpringAnimation(),
        "/timing": (_) => TimingAnimation(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var screens = [
      ["Carousel", "/carousel"],
      ["Spring Animation", "/spring"],
      ["Timing Animation", "/timing"]
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Remaths Example"),
      ),
      body: Container(
        child: ListView.builder(
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
      ),
    );
  }
}
