import 'dart:async';
import 'package:first_flutter_flame_app/my_first_game/config/game_config.dart';
import 'package:first_flutter_flame_app/my_first_game/green_world.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GreenGame extends FlameGame<GreenWorld> with KeyboardEvents, HasCollisionDetection {
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

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final bool isLeftPressed = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final bool isRightPressed = keysPressed.contains(LogicalKeyboardKey.arrowRight);
    final bool isSpacePressed = keysPressed.contains(LogicalKeyboardKey.space);

    if (isSpacePressed) {
      world.player.jump();
    }

    if (isLeftPressed && isRightPressed) {
      world.player.stopMoving();
    } else if (isLeftPressed) {
      world.player.move(-1);
    } else if (isRightPressed) {
      world.player.move(1);
    } else {
      world.player.stopMoving();
    }

    return KeyEventResult.handled;
  }
}
