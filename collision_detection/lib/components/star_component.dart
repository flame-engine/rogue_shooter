import 'package:flame/components.dart';

import '../game.dart';

class StarComponent extends SpriteAnimationComponent with HasGameRef<SpaceShooterGame>{

  static const star_speed = 10;

  bool destroyed = false;

  StarComponent(double x, double y, SpriteAnimation animation):
    super(size: Vector2.all(20), position: Vector2(x, y) , animation: animation);

  @override
  void update(double dt) {
    super.update(dt);

    y += dt * star_speed;
    shouldRemove = y >= gameRef.size.y;
  }
}
