import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static DateTime? _lastRedirectToLoginAt;
  static bool _isBootstrapping = true;

  /// Called when the splash screen finishes its bootstrap and navigates.
  static void markBootstrapComplete() {
    _isBootstrapping = false;
  }

  static void redirectToSignIn() {
    final now = DateTime.now();
    final lastCall = _lastRedirectToLoginAt;
    if (lastCall != null && now.difference(lastCall).inMilliseconds < 900) {
      return;
    }

    // During splash bootstrap, the splash screen handles its own routing.
    // Don't interfere with the interceptor redirecting here.
    if (_isBootstrapping) {
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
