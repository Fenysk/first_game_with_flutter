import 'package:first_flutter_flame_app/app.dart';
import 'package:first_flutter_flame_app/my_first_game/green_game.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();

  Game game = GreenGame();

  runApp(App(game: game));
}
