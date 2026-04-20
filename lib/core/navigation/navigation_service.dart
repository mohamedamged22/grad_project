import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static DateTime? _lastRedirectToLoginAt;

  static void redirectToSignIn() {
    final now = DateTime.now();
    final lastCall = _lastRedirectToLoginAt;
    if (lastCall != null && now.difference(lastCall).inMilliseconds < 900) {
      return;
    }

    final navigator = navigatorKey.currentState;
    if (navigator == null) return;

    _lastRedirectToLoginAt = now;
    navigator.pushNamedAndRemoveUntil('/signInView', (route) => false);
  }
}
