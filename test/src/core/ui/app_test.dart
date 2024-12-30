import 'package:flutter_l10n_app/src/account/account.dart';
import 'package:flutter_l10n_app/src/core/core.dart';
import 'package:flutter_l10n_app/src/home/home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../extensions/tester_x.dart';
import '../../../fakes/fakes.dart';
import '../../account/infra/preference_service_test.dart';

void main() {
  late Fakes fakes;
  late Preference preferenceEn;
  late MockPreferenceService mockPreferenceService;

  setUp(
    () {
      fakes = Fakes();
      preferenceEn = fakes.preferenceEn;
      mockPreferenceService = MockPreferenceService();
    },
  );

  Stream<Preference> mockEmitsPreference() {
    return mockPreferenceService.emitsPreference();
  }

  testWidgets(
    'should render home page',
    (tester) async {
      when(mockEmitsPreference).thenAnswer(
        (i) => Stream.value(preferenceEn),
      );
      await tester.pumpApp(
        overrides: [
          preferenceServiceProvider.overrideWithValue(mockPreferenceService),
        ],
        child: const App(),
      );
      expect(find.byType(LoadingPage), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    },
  );
}
