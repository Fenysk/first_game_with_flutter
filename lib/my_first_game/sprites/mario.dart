import 'package:first_flutter_flame_app/my_first_game/green_game.dart';
import 'package:first_flutter_flame_app/my_first_game/sprites/brick.dart';
import 'package:first_flutter_flame_app/my_first_game/sprites/goomba.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'dart:async';

class Mario extends SpriteComponent with HasGameRef<GreenGame>, CollisionCallbacks {
  static const double _gravity = 1200;
  static const double _jumpForce = -400;
  static const double _moveSpeed = 300.0;
  static const double _verticalCollisionTolerance = 5.0;
  static const double _horizontalCollisionTolerance = 5.0;

  double _verticalVelocity = 0;
  final double _maximumVerticalVelocity = 500;

  double _horizontalVelocity = 0;

  @override
  Future<void> onLoad() async {
    await _initializeSprite();
    _setupPhysics();
  }

  Future<void> _initializeSprite() async {
    sprite = await Sprite.load('mario.png');
    size = Vector2.all(50);
    position = Vector2(-200, 150);
    anchor = Anchor.center;
  }

  void _setupPhysics() {
    add(RectangleHitbox());
  }

  bool get _onGround {
    final bottomOfScreen = _getBottomOfScreen();
    final bricks = gameRef.world.children.whereType<Brick>();
    return position.y >= bottomOfScreen || _isOnAnyBrick(bricks);
  }

  bool _isOnAnyBrick(Iterable<Brick> bricks) => bricks.any(_isOnBrick);

  bool _isOnBrick(Brick brick) {
    final bool verticallyAligned = (position.y + size.y) >= brick.position.y && (position.y + size.y) <= (brick.position.y + _verticalCollisionTolerance);
    final bool horizontallyAligned = position.x + _horizontalCollisionTolerance >= brick.position.x && position.x - _horizontalCollisionTolerance <= (brick.position.x + brick.size.x);

    return verticallyAligned && horizontallyAligned;
  }

  double _getBottomOfScreen() => (gameRef.size.y / 2) - (size.y / 2);

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Goomba) {
      _handleGoombaCollision(other);
    } else if (other is Brick) {
      _handleBrickCollision(other);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void _handleGoombaCollision(Goomba goomba) {
    if (_isMarioAboveGoomba(goomba)) {
      goomba.removeFromParent();
      _verticalVelocity = _jumpForce / 2;
    }
  }

  bool _isMarioAboveGoomba(Goomba goomba) {
    return position.y + size.y - _verticalCollisionTolerance < goomba.position.y;
  }

  void _handleBrickCollision(Brick brick) {
    if (_isFallingOntoBrick(brick)) {
      _landOnBrick(brick);
    } else if (_isCollidingFromLeft(brick)) {
      _stopAtLeftSide(brick);
    } else if (_isCollidingFromRight(brick)) {
      _stopAtRightSide(brick);
    }
  }

  bool _isFallingOntoBrick(Brick brick) {
    return position.y + size.y <= brick.position.y + _verticalCollisionTolerance && _verticalVelocity > 0;
  }

  bool _isCollidingFromLeft(Brick brick) {
    return position.x + size.x >= brick.position.x - _horizontalCollisionTolerance && position.x < brick.position.x && position.y + size.y > brick.position.y && position.y < brick.position.y + brick.size.y;
  }

  bool _isCollidingFromRight(Brick brick) {
    return position.x <= brick.position.x + brick.size.x + _horizontalCollisionTolerance && position.x + size.x > brick.position.x + brick.size.x && position.y + size.y > brick.position.y && position.y < brick.position.y + brick.size.y;
  }

  void _landOnBrick(Brick brick) {
    position.y = brick.position.y - size.y;
    _verticalVelocity = 0;
  }

  void _stopAtLeftSide(Brick brick) {
    position.x = brick.position.x - size.x;
    _horizontalVelocity = 0;
  }

  void _stopAtRightSide(Brick brick) {
    position.x = brick.position.x + brick.size.x;
    _horizontalVelocity = 0;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Brick) {
      _handleBrickCollision(other);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double deltaTime) {
    super.update(deltaTime);
    _updatePhysics(deltaTime);
  }

  void _updatePhysics(double deltaTime) {
    _applyGravity(deltaTime);
    _applyHorizontalMovement(deltaTime);
    _checkBottomBoundary();
  }

  void _applyGravity(double deltaTime) {
    _verticalVelocity = (_verticalVelocity + _gravity * deltaTime).clamp(-_maximumVerticalVelocity, _maximumVerticalVelocity);
    position.y += _verticalVelocity * deltaTime;
  }

  void _applyHorizontalMovement(double deltaTime) {
    position.x += _horizontalVelocity * deltaTime;
  }

  void _checkBottomBoundary() {
    final bottomOfScreen = _getBottomOfScreen();
    if (position.y > bottomOfScreen) {
      position.y = bottomOfScreen;
      _verticalVelocity = 0;
    }
  }

  void move(double direction) {
    _horizontalVelocity = direction * _moveSpeed;
    if (direction != 0) {
      scale.x = direction < 0 ? -1 : 1;
    }
  }

  void stopMoving() {
    _horizontalVelocity = 0;
  }

  void jump() {
    if (_onGround) {
      _verticalVelocity = _jumpForce;
      position.y -= 10;
    }
  }
}
