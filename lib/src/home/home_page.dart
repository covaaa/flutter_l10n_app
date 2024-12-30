import 'package:flutter/material.dart';
import 'package:flutter_l10n_app/src/account/account.dart';
import 'package:flutter_l10n_app/src/l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _counter = 0;

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final theme = Theme.of(context);
    final asyncPreference = ref.watch(readPreferenceProvider);
    ref.listen(
      updatePreferenceProvider,
      (previous, next) => next.whenOrNull(
        error: (e, s) => ref.invalidate(updatePreferenceProvider),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.inversePrimary,
        title: Text(l10n.title),
        actions: asyncPreference.whenOrNull(
          data: (preference) => [
            IconButton(
              onPressed: () => LocaleUpdateSheet.show(
                context,
                preference: preference.copyWith(
                  some(
                    preference.locale.getOrElse(
                      () => SealedLocale.fromLocale(
                        Localizations.localeOf(context),
                      ),
                    ),
                  ),
                ),
              ),
              icon: const Icon(Icons.translate),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.increment_title,
              style: theme.textTheme.titleMedium,
            ),
            Text(
              '$_counter ${l10n.increment_suffix}',
              style: theme.textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: l10n.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
