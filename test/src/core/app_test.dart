import 'package:flutter_l10n_app/src/core/app.dart';
import 'package:flutter_l10n_app/src/home/home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../extensions/tester_x.dart';

void main() {
  testWidgets(
    'should render',
    (tester) async {
      await tester.pumpApp(child: const App());
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    },
  );
}
