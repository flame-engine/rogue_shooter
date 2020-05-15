import 'package:flame/flame.dart';

class Audio {
  static bool audioEnabled = false;

  static void explosion() {
    if (audioEnabled) {
      Flame.audio.play('small-explosion.wav');
    }
  }

  static void backgroundMusic() {
    if (audioEnabled) {
      Flame.audio.loopLongAudio('space-idea.mp3');
    }
  }
}
