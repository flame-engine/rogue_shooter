import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/time.dart';
import 'package:flame/components/timer_component.dart';
import 'package:flame/text_config.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';

import './components/player_component.dart';
import './components/enemy_creator.dart';
import './components/star_background_creator.dart';
import './components/score_component.dart';
import './audio.dart';

class SpaceShooterGame extends BaseGame with PanDetector {

  PlayerComponent player;
  StarBackGroundCreator starBackGroundCreator;

  int score = 0;
  bool _musicStarted = false;

  final debugTextconfig = const TextConfig(color: const Color(0xFFFFFFFF));

  SpaceShooterGame(Size size) {
    this.size = size;
    _initPlayer();

    add(EnemyCreator());
    add(starBackGroundCreator = StarBackGroundCreator(size));
    starBackGroundCreator.init();

    add(ScoreComponent());
  }

  void _initPlayer() {
    add(player = PlayerComponent());
  }

  @override
  bool recordFps() => true;

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    debugTextconfig.render(canvas, fps(120).toString(), Position(0, 50));
    debugTextconfig.render(canvas, 'Objects: ${components.length}', Position(0, 100));
  }

  @override
  void onPanStart(_) {
    if (!_musicStarted) {
      _musicStarted = true;
      Audio.backgroundMusic();
    }
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
