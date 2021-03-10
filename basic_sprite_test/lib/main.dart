import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import 'dart:math';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class Component {
  final Vector2 position;
  final Vector2 direction;

  Component(this.position, this.direction);
}

class MyGame extends Game with FPSCounter {

  static final spriteSize = Vector2(100, 150);
  static const speed = 100;

  final debugTextconfig = TextConfig(color: Color(0xFFFFFFFF));

  final fpsPos = Vector2(10, 10);
  final objectsCountPos = Vector2(10, 30);

  List<Component> components;
  Sprite sprite;

  @override
  Future<void> onLoad() async {
    final random = Random();
    components = List.generate(3000, (_) {
      return Component(
          Vector2(
              random.nextDouble() * (size.x - spriteSize.x),
              random.nextDouble() * (size.y - spriteSize.y),
          ),
          Vector2(
              random.nextBool() ? 1 : -1,
              random.nextBool() ? 1 : -1,
          ),
      );
    });

    sprite = await loadSprite('ship.png');
  }


  @override
  void update(double dt) {
    components.forEach((component) {
      final ammount = speed * dt;
      component.position.x += component.direction.x * ammount;
      component.position.y += component.direction.y * ammount;

      if (
          (component.position.x < 0 && component.direction.x < 0) ||
          (component.position.x + spriteSize.x > size.x && component.direction.x > 0)
      ) {
        component.direction.x *= -1;
      }

      if (
          (component.position.y < 0 && component.direction.y < 0) ||
          (component.position.y + spriteSize.y > size.y && component.direction.y > 0)
      ) {
        component.direction.y *= -1;
      }
    });
  }

  @override
  void render(Canvas canvas) {
    components.forEach((component) {
      sprite.render(canvas, position: component.position, size: spriteSize);
    });

    debugTextconfig.render(canvas, fps(120).toString(), fpsPos);
    debugTextconfig.render(canvas, 'Objects: ${components.length}', objectsCountPos);
  }
}
