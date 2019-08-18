import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageAnimatedContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PageAnimatedContainerState();
  }
}

class PageAnimatedContainerState extends State<PageAnimatedContainer> {
  // 定义视图宽高，颜色，圆角，和动画计数
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);
  int _clickCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedContainer 动画'),
      ),
      body: Center(
        child: AnimatedContainer(
          width: _width,
          height: _height,
          child: Center(
              child: Text(
            '点击次数：$_clickCount',
            style: TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          )),
          decoration: BoxDecoration(
            color: _color,
            borderRadius: _borderRadius,
          ),
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () {
          // 回调方法
          setState(() {
            // 更新状态
            final random = Random();
            // 随机修改属性
            int _resultWidth = random.nextInt(6);
            _resultWidth = _resultWidth < 1 ? 1 : _resultWidth;
            _width = (_resultWidth * 50).toDouble();
            int _resultHeight = random.nextInt(6);
            _resultHeight = _resultHeight < 1 ? 1 : _resultHeight;
            _height = (_resultHeight * 50).toDouble();
            _color = Color.fromRGBO(random.nextInt(256), random.nextInt(256), random.nextInt(256), 1);
            _borderRadius = BorderRadius.circular(random.nextDouble() * 100);
            _clickCount++;
          });
        },
      ),
    );
  }
}
