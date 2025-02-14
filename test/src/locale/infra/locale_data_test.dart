import 'package:flutter_l10n_app/src/locale/locale.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should get locale', () {
    expect(LocaleData.en.domain, const LocaleEn());
    expect(LocaleData.ja.domain, const LocaleJa());
  });
}
