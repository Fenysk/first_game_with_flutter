import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends CircleComponent {
  Player({
    required super.position,
    required super.radius,
    Color color = Colors.white,
  }) : super(
          anchor: Anchor.center,
          paint: Paint()
            ..color = color
            ..style = PaintingStyle.fill,
        );
}
