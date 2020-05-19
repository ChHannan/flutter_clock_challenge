// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';

class ClockCircles extends StatelessWidget {
  const ClockCircles();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CustomPaint(
        painter: _Circle(),
      ),
    );
  }
}

class _Circle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    /// Calculating angle at which circles has to be drawn.
    final _angle = 2 * math.pi / 60;

    /// Radius of distance at which circles has to drawn.
    final _radius = size.height / 2;
    final _secondCircles = new Paint()
      ..color = Colors.white
      ..strokeWidth = 3;

    final _fiveSecondCircles = new Paint()
      ..color = Color(0xff53cfff)
      ..strokeWidth = 5;

    /// Translating to the middle of the container.
    canvas.translate(size.width / 2, _radius);

    for (var i = 0; i < 60; i++) {
      if (i % 5 == 0) {
        canvas.drawCircle(Offset(0.0, _radius), 4, _fiveSecondCircles);
      } else {
        canvas.drawCircle(Offset(0.0, _radius), 3, _secondCircles);
      }

      /// Rotating canvas to draw at calculated angle.
      canvas.rotate(_angle);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
