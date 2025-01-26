import 'dart:async';
import 'package:first_flutter_flame_app/my_first_game/config/game_config.dart';
import 'package:first_flutter_flame_app/my_first_game/player.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GreenGame extends FlameGame {
  GreenGame({
    super.children,
  }) : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  @override
  FutureOr<void> onLoad() {
    world.add(Player(
      position: Vector2(-50, 0),
      radius: gameWidth / 7,
      color: Colors.yellow,
    ));

    world.add(Player(
      position: Vector2(100, 100),
      radius: gameWidth / 15,
      color: Colors.red,
    ));

    world.add(Player(
      position: Vector2(250, 100),
      radius: gameWidth / 15,
      color: Colors.red,
    ));

    return super.onLoad();
  }

  @override
  Color backgroundColor() => Colors.green;
}
