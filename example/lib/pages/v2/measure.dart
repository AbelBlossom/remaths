import 'package:flutter/material.dart';
import 'package:remaths/v2/core/core.dart';

class V2MeasureTest extends StatefulWidget {
  const V2MeasureTest({super.key});

  @override
  State<V2MeasureTest> createState() => _V2MeasureTestState();
}

class _V2MeasureTestState extends State<V2MeasureTest> {
  List<Widget> widgets = List.generate(30, (index) => Tile(index: index));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widgets,
        ),
      ),
    );
  }
}

class Tile extends StatefulWidget {
  final int index;
  const Tile({
    super.key,
    required this.index,
  });

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  Measurement? g;
  @override
  Widget build(BuildContext context) {
    return MeasureWidget(
      index: widget.index,
      onMeasured: (measurement) {
        print("measured");
        setState(() {
          g = measurement;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width,
        height: 50,
        color: Colors.blueAccent,
        child: Text(g != null ? "${g!.size}, y:${g!.y} x:${g!.x}" : "Not Yet"),
      ),
    );
  }
}
