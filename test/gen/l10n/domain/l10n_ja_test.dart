import 'package:flutter_l10n_app/gen/l10n/domain/l10n_ja.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late L10nJa l10n;

  setUp(() {
    l10n = L10nJa();
  });

  test(
    'should get values',
    () {
      expect(l10n.locale, '日本語');
      expect(l10n.language, '言語');
      expect(l10n.title, '多言語アプリ');
      expect(l10n.done, '完了');
      expect(l10n.increment, '増やす');
      expect(l10n.increment_title, '何回ボタンを押したかというと...');
      expect(l10n.increment_suffix, '回');
    },
  );
}
