import 'package:first_flutter_flame_app/my_first_game/config/game_config.dart';
import 'package:first_flutter_flame_app/my_first_game/green_world.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GreenGame extends FlameGame {
  GreenGame({
    super.children,
  }) : super(
          world: GreenWorld(),
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  @override
  Color backgroundColor() => Colors.green;
}
