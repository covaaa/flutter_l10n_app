import 'dart:ui';
import 'package:flutter_l10n_app/src/l10n/infra/locale_data.dart';

final class LocaleEn extends SealedLocale {
  const LocaleEn() : super._('en');
}

final class LocaleJa extends SealedLocale {
  const LocaleJa() : super._('ja');
}

sealed class SealedLocale extends Locale {
  const SealedLocale._(super.languageCode);

  LocaleData get data {
    return switch (this) {
      LocaleEn() => LocaleData.en,
      LocaleJa() => LocaleData.ja,
    };
  }
}
