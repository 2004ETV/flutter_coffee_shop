import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/src/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl_standalone.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await findSystemLocale();

  await dotenv.load();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
