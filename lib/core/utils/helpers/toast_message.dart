import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ToastHelper {
  static const MethodChannel _channel = MethodChannel('toast_channel');

  static Future<void> showCustomToast(String message) async {
    try {
      await _channel.invokeMethod('showCustomToast', {'message': message});
    } on PlatformException catch (err) {
      debugPrint("Failed to show toast: ${err.message}");
    }
  }
}
