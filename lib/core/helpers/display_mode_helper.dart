import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

class DisplayModeHelper {
  static Future<void> setOptimalDisplayMode() async {
    try {
      // Get all available modes
      final List<DisplayMode> modes = await FlutterDisplayMode.supported;

      // Sort modes by refresh rate (highest to lowest)
      modes.sort((a, b) => b.refreshRate.compareTo(a.refreshRate));

      // Get the optimal mode (highest refresh rate)
      final DisplayMode optimalMode = modes.first;

      // Set the optimal mode
      await FlutterDisplayMode.setPreferredMode(optimalMode);

      // Optional: Print current mode for debugging
      final DisplayMode current = await FlutterDisplayMode.active;
      debugPrint('Set display mode to: ${current.refreshRate}Hz');
    } on PlatformException catch (e) {
      debugPrint('Failed to set display mode: ${e.message}');
    } catch (e) {
      debugPrint('Error setting display mode: $e');
    }
  }

  static Future<void> setHighRefreshRate() async {
    try {
      // Set to highest refresh rate mode
      await FlutterDisplayMode.setHighRefreshRate();

      // Optional: Print current mode for debugging
      final DisplayMode current = await FlutterDisplayMode.active;
      debugPrint('Set to high refresh rate: ${current.refreshRate}Hz');
    } on PlatformException catch (e) {
      debugPrint('Failed to set high refresh rate: ${e.message}');
    } catch (e) {
      debugPrint('Error setting high refresh rate: $e');
    }
  }

  static Future<double> getCurrentRefreshRate() async {
    try {
      final DisplayMode current = await FlutterDisplayMode.active;
      return current.refreshRate;
    } catch (e) {
      debugPrint('Error getting refresh rate: $e');
      return 60.0; // Default fallback
    }
  }
}
