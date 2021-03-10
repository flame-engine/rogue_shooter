import 'package:flame/components.dart';
import 'package:flame/timer.dart';

import 'dart:ui';
import 'dart:math';

import '../game.dart';

import './enemy_component.dart';

class EnemyCreator extends Component with HasGameRef<SpaceShooterGame>{

  Timer enemyCreator;

  Random random = Random();

  EnemyCreator() {
    enemyCreator = Timer(0.05, repeat: true, callback: () {
      gameRef.add(EnemyComponent((gameRef.size.x - 25) * random.nextDouble(), 0));
      gameRef.add(EnemyComponent((gameRef.size.x - 25) * random.nextDouble(), 0));
      gameRef.add(EnemyComponent((gameRef.size.x - 25) * random.nextDouble(), 0));
      gameRef.add(EnemyComponent((gameRef.size.x - 25) * random.nextDouble(), 0));
      gameRef.add(EnemyComponent((gameRef.size.x - 25) * random.nextDouble(), 0));
    });
    enemyCreator.start();
  }

  @override
  void update(double dt) {
    enemyCreator.update(dt);
  }

  @override
  void render(Canvas canvas) { }
}
