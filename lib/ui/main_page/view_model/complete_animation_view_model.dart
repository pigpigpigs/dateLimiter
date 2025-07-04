import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'complete_animation_view_model.g.dart';

@riverpod
class CompleteAnimationFlug extends _$CompleteAnimationFlug {
  @override
  bool build() {
    return false;
  }

  bool animationFlugChanger(bool bool) {
    return state = bool;
  }
}
