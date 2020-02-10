import 'package:flutter/material.dart';
import 'wall_paper.dart';
import 'package:wall_paper/full_image.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'FullImage': (context) => FullImage(),
//        'SearchBar': (context) => SearchBarTool(),
      },
      home: Wallpaper(),
    );
  }
}
