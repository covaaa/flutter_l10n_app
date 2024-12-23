import 'package:flutter/material.dart';
import 'package:flutter_l10n_app/src/core/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Counter increments smoke test',
    (tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('0 times'), findsOneWidget);
      expect(find.text('1 times'), findsNothing);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('0 times'), findsNothing);
      expect(find.text('1 times'), findsOneWidget);
    },
  );
}
