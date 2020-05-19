// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:analog_clock/Utils/calculations.dart';
import 'package:analog_clock/Utils/colors.dart';
import 'package:analog_clock/clock_widgets/clock_center.dart';
import 'package:analog_clock/clock_widgets/clock_circles.dart';
import 'package:analog_clock/clock_widgets/drawn_hand.dart';
import 'package:analog_clock/clock_widgets/second_circle.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' show radians;


/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

class AnalogClock extends StatefulWidget {
  const AnalogClock(this.model);

  final ClockModel model;

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  DateTime _now = DateTime.now();
  String _temperature = '';
  String _location = '';
  Color _backgroundColor;
  Timer _timer;
  List<String> _weatherAnimation;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(AnalogClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _location = widget.model.location;

      /// Calculating clock background color whenever model updates.
      _backgroundColor = colorCalculation(
        _temperature,
        widget.model.unit.toString(),
      );
      _weatherAnimation = animationDecider(
        widget.model.weatherCondition.toString(),
      );
    });
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            backgroundColor: _backgroundColor,
          )
        : Theme.of(context).copyWith(
            backgroundColor: kDarkBackgroundColor,
          );

    final time = DateFormat.Hms().format(DateTime.now());

    final weatherInfo = DefaultTextStyle(
      style: TextStyle(color: kHandColor, fontSize: 10),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_temperature),
            Text(_location),
          ],
        ),
      ),
    );

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time $time',
        value: time,
      ),
      child: AnimatedContainer(
        curve: Curves.easeInOut,
        duration: Duration(seconds: 2),
        color: customTheme.backgroundColor,
        child: Stack(
          alignment: Alignment.center,
          children: [
            FlareActor(
              _weatherAnimation[0],
              animation: _weatherAnimation[1],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: const ClockCircles(),
            ),
            // Hour Hand
            DrawnHand(
              color: kHandColor,
              thickness: 7,
              size: 0.60,
              angleRadians: _now.minute * radiansPerTick,
            ),
            // Minute Hand
            DrawnHand(
              color: kHandColor,
              thickness: 7,
              size: 0.40,
              angleRadians: _now.hour * radiansPerHour +
                  (_now.minute / 60) * radiansPerHour,
            ),
            // Using const to prevent the widget from rebuilding.
            const LowerCircle(),
            const UpperCircle(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SecondCircle(
                angleRadians: _now.second * radiansPerTick,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: weatherInfo,
            ),
          ],
        ),
      ),
    );
  }
}
