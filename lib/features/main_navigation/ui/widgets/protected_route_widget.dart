import 'package:flutter/material.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';

class ProtectedRoute extends StatelessWidget {
  final Widget child;
  final AuthNavigationService authService;

  const ProtectedRoute({
    super.key,
    required this.child,
    required this.authService,
  });

  @override
  Widget build(BuildContext context) {
    return authService.isGuestMode
        ? Builder(
            builder: (context) {
              // Show guest dialog and return empty container
              WidgetsBinding.instance.addPostFrameCallback((_) {
                GuestDialogService.showGuestRestriction();
              });
              return const SizedBox.shrink();
            },
          )
        : child;
  }
}
