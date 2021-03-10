import 'package:flame/components.dart';

import 'dart:ui';

import '../game.dart';

class ScoreComponent extends TextComponent with HasGameRef<SpaceShooterGame> {
  ScoreComponent() : super(
      "Score 0",
      config: TextConfig(color: Color(0xffffffff)),
      position: Vector2.all(5),
  );

  @override
  void update(double dt) {
    super.update(dt);
    text = "Score ${gameRef.score}";
  }
}
