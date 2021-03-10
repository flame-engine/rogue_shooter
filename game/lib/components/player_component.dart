import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import 'package:flame/timer.dart';

import '../game.dart';

import './bullet_component.dart';
import './explosion_component.dart';

class PlayerComponent extends SpriteAnimationComponent with HasGameRef<SpaceShooterGame>, Hitbox, Collidable {

  bool destroyed = false;
  Timer bulletCreator;

  PlayerComponent(): super(size: Vector2(50, 75), position: Vector2(100, 500)) {
    bulletCreator = Timer(0.05, repeat: true, callback: _createBullet);

    addShape(HitboxRectangle());
  }

  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation('player.png', SpriteAnimationData.sequenced(
            stepTime: 0.2,
            amount:  4,
            textureSize: Vector2(32, 48),
    ));
  }

  void _createBullet() {
    final bulletX = x + 20;
    final bulletY = y + 20;

    gameRef.add(BulletComponent(bulletX, bulletY));
    gameRef.add(BulletComponent(bulletX, bulletY, xDirection: 0.5));
    gameRef.add(BulletComponent(bulletX, bulletY, xDirection: 0.3));
    gameRef.add(BulletComponent(bulletX, bulletY, xDirection: -0.5));
    gameRef.add(BulletComponent(bulletX, bulletY, xDirection: -0.3));
  }

  void beginFire() {
    bulletCreator.start();
  }

  void stopFire() {
    bulletCreator.stop();
  }

  void move(double deltaX, double deltaY) {
    x += deltaX;
    y += deltaY;
  }

  @override
  void update(double dt) {
    super.update(dt);

    bulletCreator.update(dt);

    shouldRemove = destroyed;
  }

  void takeHit() {
    gameRef.add(ExplosionComponent(x, y));
  }
}
