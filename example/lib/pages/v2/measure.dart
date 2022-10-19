import 'package:flutter/material.dart';
import 'package:remaths/v2/core/core.dart';

class V2MeasureTest extends StatefulWidget {
  const V2MeasureTest({super.key});

  @override
  State<V2MeasureTest> createState() => _V2MeasureTestState();
}

class _V2MeasureTestState extends State<V2MeasureTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return const Tile();
        },
      ),
    );
  }
}

class Tile extends StatefulWidget {
  const Tile({super.key});

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  Measurement? g;
  @override
  Widget build(BuildContext context) {
    return MeasureWidget(
      onMeasured: (measurement) {
        print("measured");
        setState(() {
          g = measurement;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: 100,
        height: 50,
        color: Colors.blueAccent,
        child: Text(g != null ? "${g!.size}, y:${g!.y} x:${g!.x}" : "Not Yet"),
      ),
    );
  }
}
