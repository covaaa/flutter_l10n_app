import 'package:flutter/material.dart';
import 'package:flutter_l10n_app/src/account/account.dart';
import 'package:flutter_l10n_app/src/home/home_page.dart';
import 'package:flutter_l10n_app/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../extensions/tester_x.dart';
import '../../fakes/fakes.dart';
import '../account/infra/preference_service_test.dart';

void main() {
  late Fakes fakes;
  late Preference preferenceNone;
  late Preference preferenceEn;
  late Preference preferenceJa;
  late LocaleEn localeEn;
  late LocaleJa localeJa;
  late MockPreferenceService mockPreferenceService;

  setUp(
    () {
      fakes = Fakes();
      preferenceNone = fakes.preferenceNone;
      preferenceEn = fakes.preferenceEn;
      preferenceJa = fakes.preferenceJa;
      localeEn = fakes.localeEn;
      localeJa = fakes.localeJa;
      mockPreferenceService = MockPreferenceService();
      registerFallbackValue(preferenceEn);
    },
  );

  Future<void> mockUpdatePreferenceEn() {
    return mockPreferenceService.updatePreference(preferenceEn);
  }

  Future<void> mockUpdatePreferenceJa() {
    return mockPreferenceService.updatePreference(preferenceJa);
  }

  Stream<Preference> mockEmitsPreference() {
    return mockPreferenceService.emitsPreference();
  }

  testWidgets(
    'counter increments smoke test',
    (tester) async {
      when(mockEmitsPreference).thenAnswer((i) => Stream.value(preferenceEn));
      await tester.pumpApp(
        overrides: [
          preferenceServiceProvider.overrideWithValue(mockPreferenceService),
        ],
        child: const HomePage(),
      );
      await tester.pumpAndSettle();
      expect(find.text('0 times'), findsOneWidget);
      expect(find.text('1 times'), findsNothing);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('0 times'), findsNothing);
      expect(find.text('1 times'), findsOneWidget);
      verify(mockEmitsPreference).called(1);
    },
  );

  group(
    'update preference',
    () {
      testWidgets(
        'should success',
        (tester) async {
          when(mockEmitsPreference).thenAnswer(
            (i) => Stream.value(preferenceEn),
          );
          when(mockUpdatePreferenceJa).thenAnswer((i) async {});
          await tester.pumpApp(
            overrides: [
              preferenceServiceProvider.overrideWithValue(
                mockPreferenceService,
              ),
            ],
            child: const HomePage(),
          );
          await tester.pumpAndSettle();
          expect(find.byIcon(Icons.translate), findsOneWidget);
          await tester.tap(find.byIcon(Icons.translate));
          await tester.pumpAndSettle();
          expect(find.byType(LocaleUpdateSheet), findsOneWidget);
          await tester.tap(find.byKey(localeJa.key));
          await tester.pumpAndSettle();
          await tester.tap(find.byType(FilledButton));
          verify(mockEmitsPreference).called(1);
          verify(mockUpdatePreferenceJa).called(1);
        },
      );
      testWidgets(
        'should failed',
        (tester) async {
          when(mockEmitsPreference).thenAnswer(
            (i) => Stream.value(preferenceJa),
          );
          when(mockUpdatePreferenceEn).thenThrow(Error());
          await tester.pumpApp(
            overrides: [
              preferenceServiceProvider.overrideWithValue(
                mockPreferenceService,
              ),
            ],
            child: const HomePage(),
          );
          await tester.pumpAndSettle();
          expect(find.byIcon(Icons.translate), findsOneWidget);
          await tester.tap(find.byIcon(Icons.translate));
          await tester.pumpAndSettle();
          expect(find.byType(LocaleUpdateSheet), findsOneWidget);
          await tester.tap(find.byKey(localeEn.key));
          await tester.pumpAndSettle();
          await tester.tap(find.byType(FilledButton));
          verify(mockEmitsPreference).called(1);
          verify(mockUpdatePreferenceEn).called(1);
        },
      );
      testWidgets(
        'should back',
        (tester) async {
          when(mockEmitsPreference).thenAnswer(
            (i) => Stream.value(preferenceNone),
          );
          await tester.pumpApp(
            overrides: [
              preferenceServiceProvider.overrideWithValue(
                mockPreferenceService,
              ),
            ],
            child: const HomePage(),
          );
          await tester.pumpAndSettle();
          expect(find.byIcon(Icons.translate), findsOneWidget);
          await tester.tap(find.byIcon(Icons.translate));
          await tester.pumpAndSettle();
          expect(find.byType(LocaleUpdateSheet), findsOneWidget);
          // Rendered back button
          // Because AppBar's automaticallyImplyLeading = true
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();
          expect(find.byType(LocaleUpdateSheet), findsNothing);
          verify(mockEmitsPreference).called(1);
        },
      );
    },
  );
}
