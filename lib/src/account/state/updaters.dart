import 'package:flutter_l10n_app/src/account/domain/preference.dart';
import 'package:flutter_l10n_app/src/account/infra/preference_service.dart';
import 'package:flutter_l10n_app/src/core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'updaters.g.dart';

@riverpod
class UpdatePreference extends _$UpdatePreference with Loads {
  late PreferenceService _service;

  @override
  FutureOr<Option<Unit>> build() async {
    _service = ref.watch(preferenceServiceProvider);
    return none();
  }

  Future<Unit> run(Preference preference) async {
    return super.load(
      Task(() async => _service.updatePreference(preference)).map(
        (_) => some(unit),
      ),
    );
  }
}
