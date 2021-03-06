import 'dart:math';
import 'package:flutter/material.dart';
import './sun_moon.dart';
import './utils.dart';

class DayNightBanner extends StatelessWidget {
  final int hour;
  final double displace;
  final Image sunAsset;
  final Image moonAsset;

  DayNightBanner({
    this.hour,
    this.displace = 0,
    this.sunAsset,
    this.moonAsset,
  });

  Color getColor(bool isDay, bool isDusk) {
    if (!isDay) {
      return Colors.blueGrey[900];
    }
    if (isDusk) {
      return Colors.orange[400];
    }
    return Colors.blue[200];
  }

  @override
  Widget build(BuildContext context) {
    final isDay = hour >= 6 && hour <= 18;
    final isDusk = hour >= 16 && hour <= 18;
    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      duration: Duration(seconds: 1),
      height: 150,
      color: getColor(isDay, isDusk),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth.round() - SUN_MOON_WIDTH;
          final top = sin(pi * displace) * 1.8;
          final left = (maxWidth * displace);
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedPositioned(
                curve: Curves.ease,
                child: SunMoon(
                  isSun: isDay,
                  sunAsset: sunAsset,
                  moonAsset: moonAsset,
                ),
                bottom: top * 20,
                left: left,
                duration: Duration(milliseconds: 200),
              ),
            ],
          );
        },
      ),
    );
  }
}
