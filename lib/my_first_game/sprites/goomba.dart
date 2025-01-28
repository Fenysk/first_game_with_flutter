import 'package:first_flutter_flame_app/my_first_game/green_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:async';

class Goomba extends SpriteComponent with HasGameRef<GreenGame>, CollisionCallbacks {
  final double initialXPostition;
  bool _directionRight = false;

  Goomba({required this.initialXPostition});

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('goomba.png');
    size = Vector2.all(50);
    position = Vector2(initialXPostition, 225);
    anchor = Anchor.center;

    add(RectangleHitbox());
  }

  @override
  void update(double deltaTime) {
    super.update(deltaTime);
    if (_directionRight) {
      position.x += deltaTime * 100;
    } else {
      position.x -= deltaTime * 100;
    }
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    // This line calculates the average horizontal position of collision points to determine which side the Goomba should bounce off.
    final double averageX = intersectionPoints.map((point) => point.x).reduce((a, b) => a + b) / intersectionPoints.length;
    _directionRight = averageX < position.x;
  }
}
