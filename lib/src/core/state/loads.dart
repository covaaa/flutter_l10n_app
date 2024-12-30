import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

mixin Loads<T> on AutoDisposeAsyncNotifier<T> {
  Future<Unit> load(Task<T> task) async {
    state = AsyncLoading<T>();
    state = await AsyncValue.guard<T>(() => task.run());
    return unit;
  }
}
