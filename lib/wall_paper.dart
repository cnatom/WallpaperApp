import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wall_paper/global.dart';
import 'package:dio/dio.dart';
import 'package:wall_paper/photos.dart';
class Wallpaper extends StatefulWidget {
  @override
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  getWallpaper()async{
    Response res;
    Dio dio = Dio();
    //配置dio信息
    res = await dio.get(
        "https://api.pexels.com/v1/curated?per_page=15&page=1",
        queryParameters: {"per_page":15,"page":1},
        options: Options(
            headers:{"Authorization":"563492ad6f91700001000001a7040101ff4c4baabd2f9eb872b1081f"}
        ));
    //Json解码为Map
    Map<String,dynamic> photomap = jsonDecode(res.toString());
    Global.photos = (photomap['photos'] as List).map((data) => Photos.fromJson(data)).toList();
    setState(() {});
  }

  @override
  void initState() {
    getWallpaper();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Wallpapers'),
        elevation: 5.0,
//        actions: <Widget>[
//          Padding(
//            padding: EdgeInsets.only(right: 10.0),
//            child: IconButton(
//              icon: Icon(Icons.search),
//              onPressed: () {
//                Navigator.of(context).pushNamed('SearchBar');
//              },
//            ),
//          )
//        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 5.0),
        child: GridView.builder(
          itemCount: 10,
//          itemCount: Global.photos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,//列数
              mainAxisSpacing: 10,//主轴
              crossAxisSpacing: 5,//幅轴
              childAspectRatio: 0.8),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Global.index = index;
                Navigator.of(context).pushNamed('FullImage');
              },
              child: Hero(
                tag: index,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(
                        Global.photos[index].src.tiny,
                      ),
                      fit: BoxFit.cover,
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
