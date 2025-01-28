import 'dart:async';
import 'package:first_flutter_flame_app/my_first_game/green_game.dart';
import 'package:first_flutter_flame_app/my_first_game/player.dart';
import 'package:flame/components.dart';

class GreenWorld extends World with HasGameRef<GreenGame> {
  late final Player player;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    player = Player();
    add(player);
  }
}
