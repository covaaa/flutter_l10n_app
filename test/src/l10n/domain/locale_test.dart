import 'package:flutter_l10n_app/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'should get data',
    () {
      expect(const LocaleEn().data, equals(LocaleData.en));
      expect(const LocaleJa().data, equals(LocaleData.ja));
    },
  );
}
