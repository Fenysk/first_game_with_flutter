import 'dart:async';

import 'package:first_flutter_flame_app/my_first_game/config/game_config.dart';
import 'package:first_flutter_flame_app/my_first_game/green_world.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GreenGame extends FlameGame<GreenWorld> with HorizontalDragDetector, KeyboardEvents, HasCollisionDetection {
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
  void onHorizontalDragUpdate(DragUpdateInfo info) {
    super.onHorizontalDragUpdate(info);

    world.player.move(info.delta.global.x);
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    const double moveSpeed = 55.0;

    final bool isLeftPressed = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final bool isRightPressed = keysPressed.contains(LogicalKeyboardKey.arrowRight);

    if (isLeftPressed && isRightPressed) {
      return KeyEventResult.ignored;
    } else if (isLeftPressed) {
      world.player.move(-moveSpeed);
      return KeyEventResult.handled;
    } else if (isRightPressed) {
      world.player.move(moveSpeed);
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }
}
