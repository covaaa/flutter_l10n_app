import 'package:flutter_l10n_app/src/l10n/domain/locale.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'readers.g.dart';

@riverpod
class ReadLocale extends _$ReadLocale {
  @override
  SealedLocale build() => const LocaleJa();
  SealedLocale en() => state = const LocaleEn();
  SealedLocale ja() => state = const LocaleJa();
}
