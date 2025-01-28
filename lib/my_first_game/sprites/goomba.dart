import 'package:first_flutter_flame_app/my_first_game/green_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:async';

class Goomba extends SpriteComponent with HasGameRef<GreenGame> {
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('goomba.png');
    size = Vector2.all(100);
    position = Vector2(0, 200);
    anchor = Anchor.center;

    add(RectangleHitbox());
  }
}
