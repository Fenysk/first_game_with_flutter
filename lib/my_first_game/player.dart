import 'package:first_flutter_flame_app/my_first_game/green_game.dart';
import 'package:flame/components.dart';
import 'dart:async';

class Player extends SpriteComponent with HasGameRef<GreenGame> {
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('mario.png');
    size = Vector2.all(100);
    position = Vector2(0, -200);
    anchor = Anchor.center;
  }

  @override
  void update(double deltaTime) {
    super.update(deltaTime);

    final bottomOfScreen = (gameRef.size.y / 2) - (size.y / 2);

    double newY = position.y + (deltaTime * 100);

    if (newY > bottomOfScreen) newY = bottomOfScreen;

    position.y = newY;
  }

  void move(double deltaX) {
    double newX = position.x += deltaX;
    position.x = newX;
  }
}
