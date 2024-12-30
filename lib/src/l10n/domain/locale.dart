import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_l10n_app/src/l10n/infra/locale_data.dart';

final class LocaleEn extends SealedLocale {
  const LocaleEn() : super._(code);
  static const code = 'en';
}

final class LocaleJa extends SealedLocale {
  const LocaleJa() : super._(code);
  static const code = 'ja';
}

sealed class SealedLocale extends Locale {
  const SealedLocale._(super.languageCode);
  factory SealedLocale.fromLocale(Locale locale) {
    return switch (locale.languageCode) {
      LocaleJa.code => const LocaleJa(),
      _ => const LocaleEn(),
    };
  }

  ValueKey<SealedLocale> get key {
    return switch (this) {
      LocaleEn() => const ValueKey(LocaleEn()),
      LocaleJa() => const ValueKey(LocaleJa()),
    };
  }

  LocaleData get data {
    return switch (this) {
      LocaleEn() => LocaleData.en,
      LocaleJa() => LocaleData.ja,
    };
  }
}
