// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart' show Color, Colors, Brightness;

Color colorCalculation(String temperature, String mode) {
  /// Getting the int part from temperature string.
  int _splitTemp = int.parse(temperature.split('.').first);
  int _temperature;

  /// Converting to celsius if temperature is in fahrenheit
  if (mode == TemperatureUnit.fahrenheit.toString()) {
    _temperature = _convertToCelsius(_splitTemp);
  } else {
    _temperature = _splitTemp;
  }

  /// Calculating color on the base of temperature.
  if (_temperature >= 40) {
    return Colors.red[800];
  } else if (_temperature >= 35 && _temperature < 40) {
    return Colors.orange[600];
  } else if (_temperature >= 30 && _temperature < 35) {
    return Colors.yellow[700];
  } else if (_temperature >= 23 && _temperature < 30) {
    return Colors.green;
  } else if (_temperature >= 16 && _temperature < 23) {
    return Colors.blue;
  } else if (_temperature >= 8 && _temperature < 16) {
    return Colors.blue[700];
  } else if (_temperature >= 0 || _temperature < 0) {
    return Colors.blue[800];
  } else {
    return Colors.blue;
  }
}

int _convertToCelsius(int degrees) {
  return ((degrees - 32.0) * 5.0 / 9.0).round();
}

enum TemperatureUnit {
  celsius,
  fahrenheit,
}

List<String> animationDecider(String weatherCondition) {
  /// Calculating the weatherCondition Animation.
  if (weatherCondition == WeatherCondition.sunny.toString()) {
    return ['assets/Sun.flr', 'Sun'];
  } else if (weatherCondition == WeatherCondition.cloudy.toString()) {
    return ['assets/Cloud.flr', 'Cloud'];
  } else if (weatherCondition == WeatherCondition.foggy.toString()) {
    return ['assets/Foggy.flr', 'none'];
  } else if (weatherCondition == WeatherCondition.rainy.toString()) {
    return ['assets/Rain.flr', 'Rain'];
  } else if (weatherCondition == WeatherCondition.snowy.toString()) {
    return ['assets/Snow.flr', 'Snow'];
  } else if (weatherCondition == WeatherCondition.thunderstorm.toString()) {
    return ['assets/ThunderStorm.flr', 'ThunderStorm'];
  } else if (weatherCondition == WeatherCondition.windy.toString()) {
    return ['assets/Wind.flr', 'Wind'];
  } else {
    return ['none', 'none'];
  }
}

enum WeatherCondition {
  cloudy,
  foggy,
  rainy,
  snowy,
  sunny,
  thunderstorm,
  windy,
}
