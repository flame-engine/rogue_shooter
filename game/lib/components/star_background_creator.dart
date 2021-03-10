import 'package:flame/components.dart';
import 'package:flame/timer.dart';
import 'package:flame/sprite.dart';

import 'dart:ui';
import 'dart:math';

import '../game.dart';
import './star_component.dart';

class StarBackGroundCreator extends Component with HasGameRef<SpaceShooterGame>{
  static const star_speed = 10;
  final gapSize = 12;

  Timer starCreator;
  SpriteSheet starsSpritesheet;
  Random random = Random();

  StarBackGroundCreator();

  @override
  Future<void> onLoad() async {
    starsSpritesheet = SpriteSheet.fromColumnsAndRows(
        image: await gameRef.images.load("stars.png"),
        rows: 4,
        columns: 4
    );

    final starGapTime = (gameRef.size.y / gapSize) / star_speed;

    starCreator = Timer(starGapTime, repeat: true, callback: () {
      _createRowOfStars(0);
    });
    starCreator.start();

    _createInitialStars();
  }

  void _createStarAt(double x, double y) {
    final animation = starsSpritesheet.createAnimation(row: random.nextInt(3), to: 4, stepTime: 0.1)
        ..variableStepTimes = [
          max(20, 100 * random.nextDouble()),
          0.1, 0.1, 0.1
        ];

    gameRef.add(StarComponent(x, y, animation));
  }
  _createRowOfStars(double y) {
    final gapSize = 6;
    double starGap = gameRef.size.x / gapSize;

    for (var i = 0; i < gapSize; i++) {
      _createStarAt(
          starGap * i + (random.nextDouble() * starGap),
          y + (random.nextDouble() * 20)
      );
    }
  }

  void _createInitialStars() {
    double rows = gameRef.size.y / gapSize;

    for (var i = 0; i < gapSize;  i++) {
      _createRowOfStars(i * rows);
    }
  }

  @override
  void update(double dt) {
    starCreator.update(dt);
  }

  @override
  void render(Canvas canvas) {}
}
