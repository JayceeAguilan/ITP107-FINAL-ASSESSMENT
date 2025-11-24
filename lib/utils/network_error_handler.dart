import 'dart:io';
import 'dart:async';

class NetworkErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is SocketException) {
      return 'No internet connection. Please check your network settings.';
    } else if (error is TimeoutException) {
      return 'Connection timed out. Please try again later.';
    } else if (error is FormatException) {
      return 'Invalid data received from server.';
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  static Future<T> retry<T>(
    Future<T> Function() operation, {
    int maxAttempts = 3,
    Duration delay = const Duration(seconds: 1),
  }) async {
    int attempts = 0;
    while (true) {
      try {
        attempts++;
        return await operation();
      } catch (e) {
        if (attempts >= maxAttempts) {
          rethrow;
        }
        await Future.delayed(delay * attempts);
      }
    }
  }
}
