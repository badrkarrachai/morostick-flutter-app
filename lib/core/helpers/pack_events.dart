import 'dart:async';

class PackEvents {
  static final StreamController<String> _hiddenPackController =
      StreamController<String>.broadcast();

  static Stream<String> get onPackHidden => _hiddenPackController.stream;

  static void notifyPackHidden(String packId) {
    _hiddenPackController.add(packId);
  }

  static void dispose() {
    _hiddenPackController.close();
  }
}
