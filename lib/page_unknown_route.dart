import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageUnknownRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('没有找到链接地址'),
      ),
    );
  }
}
