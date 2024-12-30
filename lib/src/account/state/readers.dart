import 'package:flutter_l10n_app/src/account/domain/preference.dart';
import 'package:flutter_l10n_app/src/account/infra/preference_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'readers.g.dart';

@riverpod
Stream<Preference> readPreference(Ref ref) {
  return ref.watch(
    preferenceServiceProvider.select((service) => service.emitsPreference()),
  );
}
