import 'package:drift/drift.dart';
import 'package:flutter_l10n_app/src/drift/store/infra/table_x.dart';
import 'package:flutter_l10n_app/src/l10n/l10n.dart';

class Preferences extends Table with SharedColumn {
  TextColumn get locale => textEnum<LocaleData>().nullable()();
}
