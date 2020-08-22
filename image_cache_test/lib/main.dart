import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/text_config.dart';
import 'package:flame/position.dart';
import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';

import 'dart:math';
import 'dart:ui';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final size = await Flame.util.initialDimensions();
  runApp(MyGame(size).widget);
}

class MyGame extends BaseGame {
  final debugTextconfig = TextConfig(color: Color(0xFFFFFFFF));

  @override
  bool recordFps() => true;

  MyGame(Size screenSize) {
    Random r = Random();

    int objectCount = 100;

    while (objectCount-- > 0) {
      add(
          TestComponent()
          ..x = screenSize.width * r.nextDouble()
          ..y = screenSize.height * r.nextDouble()
          ..anchor = Anchor.center
      );
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    debugTextconfig.render(canvas, fps(120).toString(), Position(0, 50));
    debugTextconfig.render(canvas, 'Objects: ${components.length}', Position(0, 100));
  }
}

class TestComponent extends SpriteComponent {
  static const SPEED = 0.25;

  TestComponent() : super.square(100, 'ember.png');

  @override
  void update(double t) {
    super.update(t);
    angle += SPEED * t;
    angle %= 2 * pi;
  }
}
