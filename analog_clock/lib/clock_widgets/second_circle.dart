// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'dart:math' as math;

class SecondCircle extends StatelessWidget {
  final double angleRadians;

  const SecondCircle({
    @required this.angleRadians,
  }) : assert(
          angleRadians != null,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CustomPaint(
        painter: _CirclePainter(angleRadians: angleRadians),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  double angleRadians;

  _CirclePainter({
    @required this.angleRadians,
  }) : assert(
          angleRadians != null,
        );

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    final angle = angleRadians - math.pi / 2.0;
    final length = size.shortestSide * 0.5;

    /// Calculating position at which second circle has to be drawn.
    final position = center + Offset(math.cos(angle), math.sin(angle)) * length;
    Paint _upperCircle = new Paint()
      ..color = Color(0xfff26e71)
      ..strokeWidth = 8;
    Paint _lowerCircle = new Paint()
      ..color = Colors.white
      ..strokeWidth = 8;
    canvas.drawCircle(position, 7, _lowerCircle);
    canvas.drawCircle(position, 5, _upperCircle);
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) {
    return oldDelegate.angleRadians != angleRadians;
  }
}
