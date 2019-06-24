import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

/// This mixin will handle animation event like, triggering animation, etc
///
///
///
/// Before triggering animation the Offset Data must be initialized,
/// It is recommended to initialize the offset in initState() override.
/// 'author: hjoshi'
/// 'date: 30-05-2019'
mixin CustomAnimationControllerMixin {
  /// This method will trigger next animation status and return a boolean falg indicating if the
  /// next animation was successfully triggered or not
  ///
  /// For triggering animation this method will take a parameter called
  /// '''AnimationController controller'''
  ///
  bool triggerAnimation(controller) {
    AnimationStatus currentStatus = controller.status;
    print(
        "AnimationController.triggerAnimation() :  Controller State: $currentStatus");
    switch (currentStatus) {
      case AnimationStatus.completed:
        controller.reverse();
        break;
      case AnimationStatus.dismissed:
        controller.forward();
        break;
      default:
        break;
    }
    AnimationStatus newStatus = controller.status;
    print(
        "AnimationController.triggerAnimation() :  Controller Next State: $newStatus");
    return currentStatus.index != newStatus.index;
  }
}

/********************************** Custom Animation Mixins*************************************/
/**
 * Add your custom animation Offsets mixin here.
 * 
 * For each different animation there should be a mixin.
 * 
 * This will allow code sepration and re-use of existing animations 
 */

/// This mixin will contain data related to animating the duration frgament at top left and tools fragment
/// at bottom right
///
/// Animation is similiar to production android app's animation
///
/// Before triggering animation the Offset Data must be initialized,
/// It is recommended to initialize the offset in initState() override.
///
/// 'author: hjoshi'
/// 'date: 30-05-2019'
mixin ToolsFragmentAnimationMixin {
  Animation<Offset> _durationPostionOffset;
  Animation<Offset> _toolsPostionOffset;

  get durationOffset => _durationPostionOffset;
  get toolsOffset => _toolsPostionOffset;

  /// This method is used to initialize the offset,
  /// method will take a parameter called
  /// '''AnimationController controller'''
  ///
  /// These offset are only useful for the above Named Animation
  void initOffset(controller) {
    _durationPostionOffset =
        Tween<Offset>(begin: Offset(0.0, -3.0), end: Offset(0.0, 0.0))
            .animate(controller);

    _toolsPostionOffset =
        Tween<Offset>(begin: Offset(0.0, 3.0), end: Offset(0.0, 0.0))
            .animate(controller);
  }
}
