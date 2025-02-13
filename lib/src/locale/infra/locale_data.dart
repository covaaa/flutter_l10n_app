import 'package:flutter_l10n_app/src/locale/domain/locale.dart';

enum LocaleData {
  en,
  ja,
}

extension LocaleDataX on LocaleData {
  SealedLocale get domain {
    return switch (this) {
      LocaleData.en => const LocaleEn(),
      LocaleData.ja => const LocaleJa(),
    };
  }
}
