// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:analog_clock/Utils/colors.dart';
import 'package:flutter/material.dart';

class LowerCircle extends StatelessWidget {
  const LowerCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kLowerCircleColor,
      ),
    );
  }
}

class UpperCircle extends StatelessWidget {
  const UpperCircle();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kUpperCircleColor,
      ),
    );
    ;
  }
}
