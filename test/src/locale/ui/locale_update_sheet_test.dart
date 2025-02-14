import 'package:flutter/material.dart';
import 'package:flutter_l10n_app/src/account/account.dart';
import 'package:flutter_l10n_app/src/locale/locale.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../extensions/tester_x.dart';
import '../../../fakes/fakes.dart';
import '../../account/infra/preference_service_test.dart';

void main() {
  late Fakes fakes;
  late Preference preferenceEn;
  late Preference preferenceJa;
  late LocaleEn localeEn;
  late LocaleJa localeJa;
  late MockPreferenceService mockPreferenceService;

  setUp(() {
    fakes = Fakes();
    preferenceEn = fakes.preferenceEn;
    preferenceJa = fakes.preferenceJa;
    localeEn = fakes.localeEn;
    localeJa = fakes.localeJa;
    mockPreferenceService = MockPreferenceService();
  });

  Future<void> mockUpdatePreferenceEn() {
    return mockPreferenceService.updatePreference(preferenceEn);
  }

  Future<void> mockUpdatePreferenceJa() {
    return mockPreferenceService.updatePreference(preferenceJa);
  }

  testWidgets('should read locale en', (tester) async {
    when(mockUpdatePreferenceEn).thenAnswer((i) async {});
    await tester.pumpApp(
      overrides: [
        preferenceServiceProvider.overrideWithValue(mockPreferenceService),
      ],
      child: LocaleUpdateSheet(preferenceJa),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(localeEn.key));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton));
    verify(mockUpdatePreferenceEn).called(1);
  });

  testWidgets('should read locale ja', (tester) async {
    when(mockUpdatePreferenceJa).thenAnswer((i) async {});
    await tester.pumpApp(
      overrides: [
        preferenceServiceProvider.overrideWithValue(mockPreferenceService),
      ],
      child: LocaleUpdateSheet(preferenceEn),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(localeJa.key));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton));
    verify(mockUpdatePreferenceJa).called(1);
  });
}
