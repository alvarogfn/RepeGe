import "dart:math";

class Dice {
  static d100() {
    return Random().nextInt(100) + 1;
  }

  static d20() {
    return Random().nextInt(20) + 1;
  }

  static d12() {
    return Random().nextInt(12) + 1;
  }

  static d10() {
    return Random().nextInt(10) + 1;
  }

  static d8() {
    return Random().nextInt(8) + 1;
  }

  static d6() {
    return Random().nextInt(6) + 1;
  }

  static d4() {
    return Random().nextInt(4) + 1;
  }

  static dCustom(int max) {
    return Random().nextInt(max) + 1;
  }
}
