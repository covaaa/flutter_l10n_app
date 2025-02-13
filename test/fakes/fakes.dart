import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_l10n_app/src/account/account.dart';
import 'package:flutter_l10n_app/src/locale/locale.dart';
import 'package:fpdart/fpdart.dart';
import 'platforms.dart';

class Fakes {
  Fakes();

  final date = DateTime.now();
  final platform = FakePathProviderPlatform();
  final connection = DatabaseConnection(
    NativeDatabase.memory(),
    closeStreamsSynchronously: true,
  );
  final localeEn = const LocaleEn();
  final localeJa = const LocaleJa();

  Preference get preferenceNone {
    return Preference(locale: none(), createdAt: date, updatedAt: date);
  }

  Preference get preferenceEn {
    return Preference(locale: some(localeEn), createdAt: date, updatedAt: date);
  }

  Preference get preferenceJa {
    return Preference(locale: some(localeJa), createdAt: date, updatedAt: date);
  }
}
