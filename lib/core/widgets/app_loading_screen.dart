import 'package:flutter/material.dart';
import 'package:morostick/core/theming/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            width: 24.0,
            height: 24.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor:
                  AlwaysStoppedAnimation<Color>(ColorsManager.mainPurple),
            ),
          ),
        ),
      ),
    );
  }
}
