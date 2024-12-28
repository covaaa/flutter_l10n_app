import 'package:flutter_l10n_app/src/core/app.dart';
import 'package:flutter_l10n_app/src/home/home_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'should render',
    (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(HomePage), findsOneWidget);
    },
  );
}
