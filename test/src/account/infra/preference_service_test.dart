import 'package:drift/drift.dart';
import 'package:flutter_l10n_app/src/account/account.dart';
import 'package:flutter_l10n_app/src/drift/store/store.dart' hide Preference;
import 'package:flutter_l10n_app/src/locale/locale.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fakes/fakes.dart';

class MockPreferenceService extends Mock implements PreferenceService {}

void main() {
  late Fakes fakes;
  late Preference preferenceEn;
  late Preference preferenceJa;
  late QueryExecutor connection;
  late ProviderContainer container;
  late PreferenceService service;

  setUp(() {
    fakes = Fakes();
    preferenceEn = fakes.preferenceEn;
    preferenceJa = fakes.preferenceJa;
    connection = fakes.connection;
    container = ProviderContainer(
      overrides: [driftDatabaseProvider.overrideWithValue(connection)],
    );
    service = container.read(preferenceServiceProvider);
  });

  tearDown(() => container.dispose());

  test('should create preference', () {
    expect(service.createPreference(preferenceEn), completion(2));
  });

  test('should update preference', () async {
    await service.createPreference(preferenceEn);
    expect(service.updatePreference(preferenceJa), completion(isA<void>()));
  });

  test('should emits some preference', () async {
    expect(
      service.emitsPreference(),
      emits(
        isA<Preference>().having(
          (preference) => preference.locale,
          'should be none locale',
          none<SealedLocale>(),
        ),
      ),
    );
  });
}
