import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_l10n_app/src/account/account.dart';
import 'package:flutter_l10n_app/src/l10n/domain/locale.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

class LocaleUpdateSheet extends ConsumerStatefulWidget {
  const LocaleUpdateSheet(this.preference, {super.key});

  final Preference preference;

  static Future<void> show(
    BuildContext context, {
    required Preference preference,
  }) {
    final theme = Theme.of(context);
    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: theme.colorScheme.surface,
      builder: (context) => LocaleUpdateSheet(preference),
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LocaleUpdateSheetState();
  }
}

class _LocaleUpdateSheetState extends ConsumerState<LocaleUpdateSheet> {
  late Option<SealedLocale> locale;

  @override
  void initState() {
    super.initState();
    locale = widget.preference.locale;
  }

  @override
  Widget build(BuildContext context) {
    const localeEn = LocaleEn();
    const localeJa = LocaleJa();
    final l10n = L10n.of(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final titleLarge = textTheme.titleLarge;

    void onChanged(SealedLocale? newLocale) {
      return setState(() => locale = optionOf(newLocale));
    }

    void readLocale() {
      locale.map(
        (newLocale) {
          final updater = ref.read(updatePreferenceProvider.notifier);
          final newPreference = widget.preference.copyWith(some(newLocale));
          if (widget.preference != newPreference) updater.run(newPreference);
          return Navigator.of(context, rootNavigator: true).pop();
        },
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            scrolledUnderElevation: 0,
            titleTextStyle: titleLarge,
            title: Text(locale.match(() => l10n, lookupL10n).language),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                RadioListTile<SealedLocale>(
                  key: localeEn.key,
                  value: localeEn,
                  onChanged: onChanged,
                  groupValue: locale.toNullable(),
                  title: Text(lookupL10n(localeEn).locale),
                ),
                RadioListTile<SealedLocale>(
                  key: localeJa.key,
                  value: localeJa,
                  onChanged: onChanged,
                  groupValue: locale.toNullable(),
                  title: Text(lookupL10n(localeJa).locale),
                ),
                Center(
                  child: FilledButton.tonal(
                    onPressed: readLocale,
                    child: Text(locale.match(() => l10n, lookupL10n).done),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
