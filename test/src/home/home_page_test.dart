import 'package:flutter/material.dart';
import 'package:flutter_l10n_app/src/home/home_page.dart';
import 'package:flutter_l10n_app/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../extensions/tester_x.dart';

void main() {
  testWidgets(
    'counter increments smoke test',
    (tester) async {
      await tester.pumpApp(child: const HomePage());
      expect(find.text('0 times'), findsOneWidget);
      expect(find.text('1 times'), findsNothing);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('0 times'), findsNothing);
      expect(find.text('1 times'), findsOneWidget);
    },
  );

  testWidgets(
    'should show locale update sheet',
    (tester) async {
      await tester.pumpApp(child: const HomePage());
      expect(find.byIcon(Icons.translate), findsOneWidget);
      await tester.tap(find.byIcon(Icons.translate));
      await tester.pumpAndSettle();
      expect(find.byType(LocaleUpdateSheet), findsOneWidget);
      // rendered back button because AppBar's automaticallyImplyLeading = true
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.byType(LocaleUpdateSheet), findsNothing);
    },
  );
}
