import 'package:flutter/material.dart';
import 'package:flutter_l10n_app/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterX on WidgetTester {
  Future<void> pumpApp({
    required Widget child,
  }) async {
    return pumpWidget(
      MaterialApp(
        supportedLocales: L10n.supportedLocales,
        localizationsDelegates: L10n.localizationsDelegates,
        home: child,
      ),
    );
  }
}
