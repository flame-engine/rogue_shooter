import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

final random = Random();

class MovingSprite extends SpriteComponent with HasGameRef {
  MovingSprite() : super(size: Vector2(100, 150));

  static const speed = 100.0;
  late final Vector2 direction;
  final Vector2 deltaPosition = Vector2.zero();

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('ship.png');
    position = Vector2.random()..multiply(gameRef.size - size);
    direction = Vector2(
      random.nextBool() ? 1 : -1,
      random.nextBool() ? 1 : -1,
    );
  }

  @override
  void update(double dt) {
    deltaPosition
      ..setFrom(direction)
      ..scale(speed * dt);
    position.add(deltaPosition);
    if ((position.x < 0 && direction.x < 0) ||
        (position.x + size.x > gameRef.size.x && direction.x > 0)) {
      direction.x *= -1;
    }

    if ((position.y < 0 && direction.y < 0) ||
        (position.y + size.y > gameRef.size.y && direction.y > 0)) {
      direction.y *= -1;
    }
  }
}

class MyGame extends FlameGame with TapDetector {
  late final TextComponent componentCounter;

  @override
  Future<void> onLoad() async {
    add(FpsTextComponent());
    add(
      componentCounter = TextComponent(
        position: size,
        anchor: Anchor.bottomRight,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    componentCounter.text = 'Components: ${children.length - 2}';
  }

  @override
  void onTap() {
    addAll(List.generate(1000, (_) => MovingSprite()));
  }
}
