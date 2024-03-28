import 'dart:math';

Future<T> safeMock<T>(
  T value, {
  Duration delay = const Duration(milliseconds: 500),
}) async {
  final success = Random().nextDouble() < 0.7;
  return success
      ? Future.delayed(delay, () => value)
      : Future.error(Exception('Some mock error'));
}
