import 'package:flutter/material.dart';
import 'package:flutter_l10n_app/src/account/account.dart';
import 'package:flutter_l10n_app/src/core/ui/loading.dart';
import 'package:flutter_l10n_app/src/home/home_page.dart';
import 'package:flutter_l10n_app/src/l10n/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const color = Colors.deepPurple;
    final asyncPreference = ref.watch(readPreferenceProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: asyncPreference.whenOrNull(
        data: (preference) => preference.locale.toNullable(),
      ),
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: L10n.localizationsDelegates,
      onGenerateTitle: (context) => L10n.of(context).title,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: color),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: color,
        ),
      ),
      home: asyncPreference.maybeWhen(
        data: (preference) => const HomePage(),
        orElse: () => const LoadingPage(),
      ),
    );
  }
}
