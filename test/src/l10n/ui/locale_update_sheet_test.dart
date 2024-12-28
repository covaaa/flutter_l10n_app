import 'package:flutter/material.dart';
import 'package:flutter_l10n_app/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../extensions/tester_x.dart';

void main() {
  late LocaleEn localeEn;
  late LocaleJa localeJa;

  setUp(
    () {
      localeEn = const LocaleEn();
      localeJa = const LocaleJa();
    },
  );

  testWidgets(
    'should read locale en',
    (tester) async {
      await tester.pumpApp(child: LocaleUpdateSheet(localeJa));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(localeEn.key));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton));
    },
  );

  testWidgets(
    'should read locale ja',
    (tester) async {
      await tester.pumpApp(child: LocaleUpdateSheet(localeEn));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(localeJa.key));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton));
    },
  );
}
