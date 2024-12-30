import 'package:flutter_l10n_app/src/account/domain/preference.dart';
import 'package:flutter_l10n_app/src/drift/store/store.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'preference_service.g.dart';

@riverpod
PreferenceService preferenceService(Ref ref) {
  return PreferenceService(ref.watch(drift.driftStoreProvider));
}

class PreferenceService {
  const PreferenceService(this.store);

  final drift.DriftStore store;

  drift.$DriftStoreManager get _managers => store.managers;

  Future<int> createPreference(Preference preference) {
    return _managers.preferences.create(preference.create);
  }

  Future<void> updatePreference(Preference preference) {
    return _managers.preferences.update(preference.update);
  }

  Stream<Preference> emitsPreference() {
    return _managers.preferences.watchSingle().map(Preference.fromDrift);
  }
}
