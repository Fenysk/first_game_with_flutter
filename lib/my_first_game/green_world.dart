import 'dart:async';
import 'package:first_flutter_flame_app/my_first_game/green_game.dart';
import 'package:first_flutter_flame_app/my_first_game/sprites/brick.dart';
import 'package:first_flutter_flame_app/my_first_game/sprites/goomba.dart';
import 'package:first_flutter_flame_app/my_first_game/sprites/mario.dart';
import 'package:flame/components.dart';

class GreenWorld extends World with HasGameRef<GreenGame> {
  late final Mario player;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    add(Brick(initialXPostition: -200));
    add(Brick(initialXPostition: 200));
    add(Goomba(initialXPostition: -50));
    add(Goomba(initialXPostition: 100));

    player = Mario();
    add(player);
  }
}
