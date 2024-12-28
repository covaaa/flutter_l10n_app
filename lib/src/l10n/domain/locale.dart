import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter_l10n_app/src/l10n/infra/locale_data.dart';

final class LocaleEn extends SealedLocale {
  const LocaleEn() : super._('en');
}

final class LocaleJa extends SealedLocale {
  const LocaleJa() : super._('ja');
}

sealed class SealedLocale extends Locale {
  const SealedLocale._(super.languageCode);

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

  R when<R>({required R Function() en, required R Function() ja}) {
    return switch (this) {
      LocaleEn() => en(),
      LocaleJa() => ja(),
    };
  }
}
