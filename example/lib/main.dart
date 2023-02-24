import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rolling Bottom Bar'),
      ),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          ColoredBox(color: Colors.black),
          ColoredBox(color: Colors.white),
          ColoredBox(color: Colors.white),
          ColoredBox(color: Colors.white),
          ColoredBox(color: Colors.white),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        controller: _controller,
        barGradient: ui.Gradient.linear(const Offset(0, 37.5), Offset(MediaQuery.of(context).size.width * .9, 37.5),
            [const Color(0xFF83449E), const Color(0xFF5F0086), const Color(0xFF1B0073), const Color(0xFF4C4091)], [0, .15, .85, 1]),
        circleGradient: ui.Gradient.linear(Offset(0, 0), Offset(60, 60), [Color(0xFFB80FEE), Color(0xFF7530BE)]),
        items: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.star, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
          Icon(Icons.access_alarm, color: Colors.white),
          Icon(Icons.delete, color: Colors.white),
        ],
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}
