import 'package:drift/drift.dart' as drift;
import 'package:equatable/equatable.dart';
import 'package:flutter_l10n_app/src/drift/store/store.dart' as store;
import 'package:flutter_l10n_app/src/locale/locale.dart';
import 'package:fpdart/fpdart.dart';

final class Preference extends Equatable {
  const Preference({
    required this.locale,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Preference.fromDrift(store.Preference preference) {
    return Preference(
      locale: optionOf(preference.locale?.domain),
      createdAt: preference.createdAt,
      updatedAt: preference.updatedAt,
    );
  }

  final Option<SealedLocale> locale;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [locale, createdAt, updatedAt];

  Preference copyWith(Option<SealedLocale> locale) {
    return Preference(
      locale: locale,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  store.PreferencesCompanion create(
    store.PreferencesCompanion Function({
      required DateTime createdAt,
      required DateTime updatedAt,
      drift.Value<int> id,
      drift.Value<LocaleData?> locale,
    }) companion,
  ) {
    final date = DateTime.now();
    return companion(
      locale: drift.Value(locale.map((some) => some.data).toNullable()),
      createdAt: date,
      updatedAt: date,
    );
  }

  store.PreferencesCompanion update(
    store.PreferencesCompanion Function({
      drift.Value<int> id,
      drift.Value<LocaleData?> locale,
      drift.Value<DateTime> createdAt,
      drift.Value<DateTime> updatedAt,
    }) companion,
  ) {
    return companion(
      locale: drift.Value(locale.map((some) => some.data).toNullable()),
      updatedAt: drift.Value(DateTime.now()),
    );
  }
}
