import 'package:flutter/material.dart';
import 'package:remaths/remaths.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel>
    with SingleTickerProviderStateMixin {
  late PageController _controller;
  double? page = 2;
  List<Color> colors = [
    Colors.teal,
    Colors.green,
    Colors.orangeAccent,
    Colors.blue,
    Colors.brown,
    Colors.amber,
  ];
  @override
  void initState() {
    _controller = PageController(initialPage: 2, viewportFraction: 0.7)
      ..addListener(() {
        setState(() {
          page = _controller.page;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carousel made-with Remaths")),
      body: Container(
        height: 500,
        margin: EdgeInsets.only(top: 30),
        child: PageView.builder(
          controller: _controller,
          itemCount: colors.length,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, position) {
            double diff = position - page!;
            var rotation = interpolate(diff,
                inputRange: [-1, 0, 1], outputRange: [-15, 0, 15]);
            var scale = interpolate(diff,
                inputRange: [-1, 0, 1], outputRange: [0.9, 1, 0.9]);
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Transform.scale(
                scale: scale!.toDouble(),
                child: Transform.rotate(
                  origin: Offset(00, 0),
                  angle: toRad(rotation!.toDouble()),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors[position],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Center(
                      child: Text(
                        "$position",
                        style: TextStyle(color: Colors.white, fontSize: 50),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
