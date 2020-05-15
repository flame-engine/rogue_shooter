import 'package:flame/components/animation_component.dart';
import 'package:flame/animation.dart';
import 'package:flame/components/mixins/has_game_ref.dart';

import '../game.dart';
import './enemy_component.dart';

class BulletComponent extends AnimationComponent with HasGameRef<SpaceShooterGame>{
  static const bullet_speed = -500;

  bool destroyed = false;

  double xDirection;

  BulletComponent(double x, double y, { this.xDirection = 0.0 }): super(10, 20, Animation.sequenced("bullet.png", 4, textureWidth: 8, textureHeight: 16)) {
      this.x = x;
      this.y = y;
    }

  @override
  void update(double dt) {
    super.update(dt);
   
    y += bullet_speed * dt;
    if (xDirection != 0) {
      x += bullet_speed * dt * xDirection;
    }

    gameRef.components
        .whereType<EnemyComponent>()
        .forEach((enemy) {
          if (enemy.toRect().overlaps(toRect())) {
            destroyed = true;

            enemy.takeHit();
          }
        });
  }

  @override
  bool destroy() => destroyed || toRect().bottom <= 0;
}
