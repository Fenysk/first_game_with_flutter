import 'package:first_flutter_flame_app/my_first_game/green_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:async';

class Brick extends SpriteComponent with HasGameRef<GreenGame> {
  final double initialXPostition;

  Brick({required this.initialXPostition});

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('brick.png');
    size = Vector2.all(50);
    position = Vector2(initialXPostition, 225);
    anchor = Anchor.center;

    add(RectangleHitbox());
  }
}
