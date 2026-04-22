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

    _lastRedirectToLoginAt = now;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigator = navigatorKey.currentState;
      if (navigator == null) return;

      final currentContext = navigator.context;
      final currentRouteName = ModalRoute.of(currentContext)?.settings.name;
      if (currentRouteName == '/signInView') {
        return;
      }

      navigator.pushNamedAndRemoveUntil('/signInView', (route) => false);
    });
  }
}
