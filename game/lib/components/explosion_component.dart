import 'package:flame/components.dart';

import '../game.dart';

class ExplosionComponent extends SpriteAnimationComponent with HasGameRef<SpaceShooterGame> {

  ExplosionComponent(double x, double y): super(
      position: Vector2(x, y),
      size: Vector2.all(50),
      removeOnFinish: true,
  );

  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation('explosion.png', SpriteAnimationData.sequenced(
      stepTime: 0.5,
      amount: 6,
      textureSize: Vector2.all(32),
    ));
  }
}

