import 'package:example/page/basic.dart';
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
      routes: {"/basic": (_) => const BasicAnimations()},
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
      ["Basic", "/basic"],
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
