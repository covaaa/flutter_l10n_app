import 'package:flutter/material.dart';
import 'package:flutter_l10n_app/gen/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'should throw flutter error',
    () => expect(() => lookupL10n(const Locale('_')), throwsFlutterError),
  );
}
