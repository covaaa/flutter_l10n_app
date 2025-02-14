import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_l10n_app/src/drift/connects/connects.dart';
import 'package:flutter_l10n_app/src/drift/store/infra/database.dart';
import 'package:flutter_l10n_app/src/drift/store/infra/table.dart';
import 'package:flutter_l10n_app/src/locale/locale.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'store.g.dart';

@riverpod
DriftStore driftStore(Ref ref) {
  final store = DriftStore(ref.watch(driftDatabaseProvider));
  ref.onDispose(store.close);
  return store;
}

@DriftDatabase(tables: [Preferences])
class DriftStore extends _$DriftStore {
  DriftStore(super.e);
  @override
  int get schemaVersion => 1;
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (OpeningDetails details) async {
        await customStatement('PRAGMA foreign_keys = ON');
        if (details.wasCreated) {
          await batch((Batch instance) {
            final date = DateTime.now();
            instance.insert(
              preferences,
              PreferencesCompanion.insert(createdAt: date, updatedAt: date),
            );
          });
        }
        if (kDebugMode) {
          // この検証は他の場所で必要無いかなりの量のコードが取り込まれる
          // よって　デバッグでのみ実行
          await validateDatabaseSchema(this);
        }
      },
    );
  }
}
