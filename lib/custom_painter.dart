import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WheelPainter extends CustomPainter {
  List<double> array;

  WheelPainter(this.array);

  Paint getColorPaint(Color color) {
    Paint paint = Paint();
    paint
      ..color = color
      ..isAntiAlias = true;
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double wheelSize = min(size.width, size.height) / 2;
    List total = List<double>(array.length);
    total[0] = array[0];
    for (int i = 1; i < array.length; i++) {
      total[i] = total[i - 1] + array[i];
    }
    // 数组相加之和
    double nbElem = total[total.length - 1];
    // 弧度。drawArc 是根据弧度来绘制的
    double radius = 2 * pi / nbElem;
    Rect boundRect = Rect.fromCircle(center: Offset(wheelSize, wheelSize), radius: wheelSize);

    Random random = Random();
    for (int i = 0; i < array.length; i++) {
      canvas.drawArc(
          boundRect,
          i == 0 ? 0 : total[i - 1] * radius,
          radius * array[i],
          true,
          getColorPaint(
              Color.fromRGBO(random.nextInt(256), random.nextInt(256), random.nextInt(256), 1)));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class CakeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(200, 200),
      painter: WheelPainter([10, 20, 30, 40, 50, 60, 70, 80, 90, 100]),
    );
  }
}
