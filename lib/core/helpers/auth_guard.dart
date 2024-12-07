import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morostick/core/services/auth_navigation_service.dart';

class AuthGuard extends StatelessWidget {
  final Widget authenticatedRoute;
  final Widget unauthenticatedRoute;

  const AuthGuard({
    super.key,
    required this.authenticatedRoute,
    required this.unauthenticatedRoute,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: context.read<AuthNavigationService>(),
      builder: (context, _) {
        return context.read<AuthNavigationService>().isAuthenticated
            ? authenticatedRoute
            : unauthenticatedRoute;
      },
    );
  }
}
