import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';

import './components/player_component.dart';
import './components/enemy_creator.dart';
import './components/star_background_creator.dart';
import './components/score_component.dart';

class SpaceShooterGame extends BaseGame with PanDetector, HasCollidables {

  PlayerComponent player;

  int score = 0;

  final debugTextconfig = TextConfig(color: Color(0xFFFFFFFF));

  @override
  Future<void> onLoad() async {
    add(player = PlayerComponent());

    add(EnemyCreator());
    add(StarBackGroundCreator());

    add(ScoreComponent());
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    debugTextconfig.render(canvas, fps(120).toString(), Vector2(0, 50));
    debugTextconfig.render(canvas, 'Objects: ${components.length}', Vector2(0, 100));
  }

  @override
  void onPanStart(_) {
    player?.beginFire();
  }

  @override
  void onPanEnd(_) {
    player?.stopFire();
  }

  @override
  void onPanCancel() {
    player?.stopFire();
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    player?.move(details.delta.dx, details.delta.dy);
  }

  void increaseScore() {
    score++;
  }

  void playerTakeHit() {
    player.takeHit();
    score = 0;
  }
}
